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
    
    private init() {}
    


    // MARK: - Functions
    /// user 컬렉션에서 friend의 uid로 검색하여 친구 닉네임 가져오기
    func fetchFriendNickname(friendUids: [String], completion : @escaping ([String]) -> Void) {
        let db = Database.database().reference()
        var friendNames =  [String]()
        for friendUid in friendUids {
            let docRef = db.child("users/\(friendUid)")
                            
            docRef.observe(.value) { snapshot in
        
                let nickName = snapshot.value(forKey: "nickName") as? String ?? ""
                friendNames.append(nickName)
            }
        }
    
        completion(friendNames)

    }
    

    func isFriendUidExist(friendUid: String, completion: @escaping (String?) -> Void) {
        let db = Database.database().reference()
        let docRef = db.child("users/\(friendUid)")
        
        docRef.observe(.value) { snapshot in
            let nickName = snapshot.value(forKey: "nickName") as? String ?? ""
            completion(nickName)

        }
        
    }
    /// firebase에 savingData 인스턴스와 userData 인스턴스 업로드
    func uploadSavingDataAndUserData(userData: User, friendUids : [String]) {
        let db = Database.database().reference()
        
        let data : [String: Any] = [
            "id": userData.id ?? "",
            "creationDate": dateToString(date: Date()) ,
            "isAlarmOn": true,
            "friends": friendUids,
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
    func uploadImage(userData: User,image : UIImage) {
         guard let imageData = image.jpegData(compressionQuality: 0.5) else { return} // 이미지 화질 조정
         let fileName = NSUUID().uuidString // 이미지네임 랜덤.
         let imageRef = Storage.storage().reference(withPath: "/auth_image/\(fileName)")
             
         imageRef.putData(imageData, metadata: nil) { _, error in
             if let error = error {
                 print("에러가 발생하였다\(error.localizedDescription)")
                 return
             }
         imageRef.downloadURL { imageUrl, _ in
                 guard let imageUrl = imageUrl?.absoluteString else {return}

             let db = Database.database().reference()
             
             db.child("users/\(userData.id ?? "")/saveInfo/weekInfo/\(userData.saveInfo.currentWeek - 1)")
                 .updateChildValues(["imageUrl":imageUrl])
                 
             }
             
         }
                 
     }
    
    /// 인증사진들 가져오기
    func fetchAuthPics(userData: User, completion : @escaping ([String]) -> Void) {
            
        let db = Database.database().reference()

        db.child("users/\(userData.id ?? "")/saveInfo/weekInfo").observe(.value) { snapshot in
            
            guard let value = snapshot.value else { return}
            do {

            let data = try JSONSerialization.data(withJSONObject: value, options: [])
            let decoder = JSONDecoder()
            let weekInfo = try decoder.decode([ThisWeek].self, from: data)

                var authPics : [String] = []
                for week in weekInfo {
                    if let imageUrl = week.imageUrl {
                    authPics.append(imageUrl)
                    }
                }
                completion(authPics)
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
    func fetchUser(userId:String,completion: @escaping((User) -> Void)) {
        
        let db = Database.database().reference()
        
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
    
}
