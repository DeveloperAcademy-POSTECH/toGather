//
//  FirebaseManager.swift
//  ToGather
//
//  Created by Seungwon Choi on 2022/06/16.
//

import Firebase
import SwiftUI
import FirebaseStorage
import FirebaseDatabase
import FirebaseCore

final class FirebaseManager: ObservableObject {
    // MARK: - Properties
    static let shared = FirebaseManager()
    let db = Database.database().reference()

    private init() {}
    
    // MARK: - Functions
    func requestFriendNickname(friendUid: String, completion: @escaping (String?) -> Void) {
        let docRef = db.child("users/\(friendUid)")
        
        docRef.observe(.value) { snapshot in
            
            guard let nickNameDict = snapshot.value as? [String : AnyObject] else {
                completion(nil)
              return
            }
            let nickName = nickNameDict["nickname"] as? String
   
            completion(nickName)
        }
    }
    
    func uploadFriendsData(userData: User, friendUids : [String]) {
        let db = Database.database().reference()
        
        print("userData.id \(userData.id ?? "")")
        db.child("users/\(userData.id ?? "")/friendUids").setValue(friendUids) { error, _ in
            if let error = error {
                print("Error writing user document: \(error)")
            } else {
                print("User document successfully written!")
            }
        }
    }
    
    /// firebase에 savingData 인스턴스와 userData 인스턴스 업로드
    func uploadUserData(userData: User, friendUids : [String]) {
        
        let data : [String: Any] = [
            "id": userData.id ?? "",
            "creationDate": dateToString(date: Date()) ,
            "isAlarmOn": true,
            "friendUids": friendUids,
            "nickname" : userData.nickname
        ]
        
        db.child("users/\(userData.id ?? "")").setValue(data) { error, _ in
            if let error = error {
                print("Error writing user document: \(error)")
            } else {
                print("User document successfully written!")
            }
        }
        
        let savingData : [String: Any] = [
            "uid": "0",
            "goalProduct": userData.saveInfo.goalProduct,
            "goalWeeks": userData.saveInfo.goalWeeks,
            "startDate": userData.saveInfo.startDate, // startDate 계산법 현재 미구현
            "savingDayOfTheWeek": userData.saveInfo.savingDayOfTheWeek,
        ]
        db.child("users/\(userData.id ?? "" )/saveInfo").setValue(savingData) { error, _ in
            if let error = error {
                print("Error writing user document: \(error)")
            } else {
                print("User document successfully written!")
            }
        }
        var weekInfo : [[String : Any]] = []
        for week in userData.saveInfo.weekInfo {
            let thisweek : [String : Any] = ["presentWeek": week.presentWeek ,
                                             "didSave": week.didSave]
            
            weekInfo.append(thisweek)
        }
        
        db.child("users/\(userData.id ?? "")/saveInfo/weekInfo").setValue(weekInfo) {
            error, _ in
                if let error = error {
                    print("Error writing user document: \(error)")
                } else {
                    print("User document successfully written!")
                }
        }

    }
    /// 이미지 파베에 업로드하기
    func uploadAuthPicAndDidSave(_ image : UIImage, to userData: User, currentWeek: Int) {
        guard let imageData = image.jpegData(compressionQuality: 0.5) else { return } // 이미지 화질 조정
        let fileName = NSUUID().uuidString // 이미지네임 랜덤.
        let imageRef = Storage.storage().reference(withPath: "/auth_image/\(fileName)")
        
        imageRef.putData(imageData, metadata: nil) { _, error in
            if let error = error {
                print("에러가 발생하였다\(error.localizedDescription)")
                return
            }
            imageRef.downloadURL { imageUrl, _ in
                guard let imageUrl = imageUrl?.absoluteString else { return }
                
                let db = Database.database().reference()
                
                db.child("users/\(userData.id ?? "")/saveInfo/weekInfo/\(currentWeek - 1)")
                    .updateChildValues(["imageUrl":imageUrl])
                
                db.child("users/\(userData.id ?? "")/saveInfo/weekInfo/\(currentWeek - 1)")
                    .updateChildValues(["didSave":true])
            }
        }
    }
    
    /// 인증사진들 가져오기

    func requestAuthPics(userData: User, completion : @escaping ((pics: [String], picsDate: [String])) -> Void) {
        
        let db = Database.database().reference()

        db.child("users/\(userData.id ?? "")/saveInfo/weekInfo").observe(.value) { snapshot in
            
            guard let value = snapshot.value else { return}
            do {

            let data = try JSONSerialization.data(withJSONObject: value, options: [])
            let decoder = JSONDecoder()
            let weekInfo = try decoder.decode([ThisWeek].self, from: data)

                var authPics : [String] = []
                var authPicsDate : [String] = []
                for week in weekInfo {
                    if let imageUrl = week.imageUrl, let date = week.date {
                        authPics.append(imageUrl)
                        authPicsDate.append(date)
                    }
                }
                completion((authPics, authPicsDate))
            } catch let DecodingError.dataCorrupted(context) {
                print(context)
            } catch let DecodingError.keyNotFound(key, context) {
                print("Key '\(key)' not found:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch let DecodingError.valueNotFound(value, context) {
                print("Value '\(value)' not found:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch let DecodingError.typeMismatch(type, context) {
                print("Type '\(type)' mismatch:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch {
                print("error: ", error)
            }
        }
            }
    
    /// 유저정보 가져오기
    func requestUser(userId:String,completion: @escaping((User) -> Void)) {
                
        db.child("users/\(userId)").observe(.value) { snapshot in
            guard let value = snapshot.value else { return}
            
         //   print(value)
            do {

                let userData = try JSONSerialization.data(withJSONObject: value, options: [])
                let decoder = JSONDecoder()
                let user = try decoder.decode(User.self, from: userData)
                completion(user)
            } catch let DecodingError.dataCorrupted(context) {
                print(context)
            } catch let DecodingError.keyNotFound(key, context) {
                print("Key '\(key)' not found:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch let DecodingError.valueNotFound(value, context) {
                print("Value '\(value)' not found:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch let DecodingError.typeMismatch(type, context) {
                print("Type '\(type)' mismatch:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch {
                print("error: ", error)
            }
        }
        
    }
    /// 유저정보들 가져오기

//    func requestUsers(userIds:[String],completion: @escaping (([User]) -> Void)) {
//
//        let db = Database.database().reference()
//        var friendDatas: [User] = []
//
//        for userId in userIds {
//            db.child("users/\(userId)").observe(.value) { snapshot in
//                guard let value = snapshot.value else { return}
//
//             //   print(value)
//                do {
//
//                    let userData = try JSONSerialization.data(withJSONObject: value, options: [])
//                    let decoder = JSONDecoder()
//                    let user = try decoder.decode(User.self, from: userData)
//                    friendDatas.append(user)
//
//                } catch let DecodingError.dataCorrupted(context) {
//                    print(context)
//                } catch let DecodingError.keyNotFound(key, context) {
//                    print("Key '\(key)' not found:", context.debugDescription)
//                    print("codingPath:", context.codingPath)
//                } catch let DecodingError.valueNotFound(value, context) {
//                    print("Value '\(value)' not found:", context.debugDescription)
//                    print("codingPath:", context.codingPath)
//                } catch let DecodingError.typeMismatch(type, context) {
//                    print("Type '\(type)' mismatch:", context.debugDescription)
//                    print("codingPath:", context.codingPath)
//                } catch {
//                    print("error: ", error)
//                }
//            }
//
//        }
//        completion(friendDatas)
//    }
//
    
    
    /// 친구 ID들 입력해서 User 데이터 한번에 가져오기
    /// - Parameters:
    ///   - userIds: 친구들 ID Array
    ///   - completion: ID에대한 User정보 반환
    func requestUsers(userIds:[String],completion: @escaping (([User]) -> Void)) {
                
        Task {
            var friendDatas: [User] = []
            try await userIds.asyncForEach { userId in
                let user = try await requestFriendUser(friendId: userId)
                if let user = user {
                    friendDatas.append(user)
                }
            }
            completion(friendDatas)
        }
    }
    
    func requestFriendUser(friendId: String) async -> User? {
        do {
            let snapshot = try await db.child("users/\(friendId)").getData()
            guard let value = snapshot.value else { return nil }
            let userData = try JSONSerialization.data(withJSONObject: value, options: [])
            let decoder = JSONDecoder()
            let user = try decoder.decode(User.self, from: userData)
            return user
        }
        catch {
            print("error")
        }
        
        return nil
    }
    
    func resetUserData(uid:String) {
           db.child("users/\(uid)")
               .removeValue()
       }

}
