//
//  FirebaseManager.swift
//  ToGather
//
//  Created by Seungwon Choi on 2022/06/16.
//

import Firebase
import SwiftUI
import FirebaseStorage


final class FirebaseManager: ObservableObject {
   // @Published var onboardingViewModel = UserViewModel()
    static let shared = FirebaseManager()
    
    private init() {}
    
    /// user 컬렉션에서 friend의 uid로 검색하여 친구 닉네임 가져오기
    func fetchFriendNickname(friendUids: [String], completion : @escaping ([String]) -> Void) {
        let db = Firestore.firestore()
        var friendNames =  [String]()
        for friendUid in friendUids {
            let docRef = db.collection("user").document(friendUid)
            
            docRef.getDocument { (document, _ ) in
                
                guard let document = document else { return}
                let nickName = document.get("nickName") as? String ?? friendUid
             
                friendNames.append(nickName)
            }
        }
    
        completion(friendNames)

    }
    
    /// user컬렉션에서 닉네임 리턴
//    func getNicknameArray(friendUids: [String]) -> [String] {
//        let db = Firestore.firestore()
//        var str: [String] = []
//        for friendUid in friendUids {
//            let docRef = db.collection("user").document(friendUid)
//
//            docRef.getDocument { (document, error ) in
//                if let document = document, document.exists {
//                    let nickName: String = document.get("nickName") as? String ?? friendUid
//                    self.nicknameArray.append(nickName)
//                    str.append(nickName)
//                } else {
//                    print("User document does not exist (failed to get freind's nickname)")
//                }
//            }
//        }
//        return str
//    }
        
    func isFriendUidExist(friendUid: String, completion: @escaping (String?) -> (Void)) {
        let db = Firestore.firestore()
        let docRef = db.collection("user").document(friendUid)
        
        var nickName: String?

        docRef.getDocument { (document, error ) in
            if let document = document, document.exists {
                nickName = document.get("nickName") as? String ?? friendUid
            } else {
                print("User document does not exist (failed to get freind's nickname)")
            }
            
            completion(nickName)
        }
        
    }
    /// firebase에 savingData 인스턴스와 userData 인스턴스 업로드
    func uploadSavingDataAndUserData(userData: User, friendUids : [String]) {
        let firestore = Firestore.firestore()

        // user 컬렉션에 userData 인스턴스 업로드
        firestore.collection("user").document(userData.id ?? "").setData([
            "id": userData.id ?? "",
            "creationDate": Date(),
            "isAlarmOn": true,
            "friends": friendUids
        ]) { err in
            if let err = err {
                print("Error writing user document: \(err)")
            } else {
                print("User document successfully written!")
            }
        }

        // saving 컬렉션에 savingData 인스턴스 업로드
        firestore.collection("saving").addDocument(data: [
            "goalProductName": userData.saveInfo.goalProduct.productName,
            "goalWeeks": userData.saveInfo.goalWeeks,
            "startDate": userData.saveInfo.startDate, // startDate 계산법 현재 미구현
            "savingDayOfTheWeek": userData.saveInfo.savingDayOfTheWeek,
        ]) { err in
            if let err = err {
                print("Error writing saving document: \(err)")
            } else {
                print("Saving document successfully written!")
            }
        }
    }
    
//    func changeViewModel(userViewModel: UserViewModel) {
//        onboardingViewModel = userViewModel
//    }
    
    func setUploadImageStructure(userData: User) {
        print(userData.id)
        Firestore.firestore().collection("authPic").document(userData.id ?? "").setData(["imageUrls": ""])
    }
    
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
             Firestore.firestore().collection("authPic").document(userData.id ?? "").updateData(["imageUrls": FieldValue.arrayUnion([imageUrl])])
             
             }
             
         }
                 
     }
    
    
    func fetchAuthPics(userData: User, completion : @escaping ([String]) -> (Void)) {
            
            Firestore.firestore().collection("authPic").document("8E64B9").getDocument { snapshot, _ in

                guard let authPics = try? snapshot?.get("imageUrls") as? [String] else {return}

                completion(authPics)

            }

            }
    
    
    func fetchUser(userId:String,completion: @escaping((User) -> Void)) {
        Firestore.firestore().collection("user")
            .document(userId ?? "")
            .getDocument { snapshot, _ in
                guard let snapshot = snapshot else {return}
                
                guard let user = try? snapshot.data(as: User.self) else {return}
                completion(user)

            }
        
    }
    
    
    
}
