//
//  FirebaseManager.swift
//  ToGather
//
//  Created by Seungwon Choi on 2022/06/16.
//

import Firebase
import SwiftUI

final class FirebaseManager: ObservableObject {
    @EnvironmentObject var onboardingViewModel: UserViewModel
    @Published var nicknameArray: [String] = []
    @Published var notification = [Notification]()

    static let shared = FirebaseManager()
    
    /// user 컬렉션에서 friend의 uid로 검색하여 친구 닉네임 가져오기
    func fetchFriendNickname(friendUids: [String]) {
        let db = Firestore.firestore()
        
        for friendUid in friendUids {
            let docRef = db.collection("user").document(friendUid)
            
            docRef.getDocument { (document, _) in
                if let document = document, document.exists {
                    let nickName: String = document.get("nickName") as? String ?? friendUid
                    self.nicknameArray.append(nickName)
                } else {
                    print("User document does not exist (failed to get freind's nickname)")
                }
            }
        }
    }
    
    /// firebase에 savingData 인스턴스와 userData 인스턴스 업로드
    func uploadSavingDataAndUserData() {
        let firestore = Firestore.firestore()

        // user 컬렉션에 userData 인스턴스 업로드
        firestore.collection("user").document(onboardingViewModel.userData.id ?? "").setData([
            "id": onboardingViewModel.userData.id ?? "",
            "creationDate": Date(),
            "isAlarmOn": true,
            "friends": onboardingViewModel.friendUids
        ]) { err in
            if let err = err {
                print("Error writing user document: \(err)")
            } else {
                print("User document successfully written!")
            }
        }

        // saving 컬렉션에 savingData 인스턴스 업로드
        firestore.collection("saving").addDocument(data: [
            "goalProductName": onboardingViewModel.userData.saveInfo.goalProduct.productName,
            "goalWeeks": onboardingViewModel.userData.saveInfo.goalWeeks,
            "startDate": "", // startDate 계산법 현재 미구현
            "savingDayOfTheWeek": onboardingViewModel.userData.saveInfo.savingDayOfTheWeek,
        ]) { err in
            if let err = err {
                print("Error writing saving document: \(err)")
            } else {
                print("Saving document successfully written!")
            }
        }
    }
    
    
    /// 알림들 가져오기
    func fetchNotifications() {
        do {
            let user  = try UserDefaults.standard.getObject(forKey: "User", castTo: User.self)
            let notificationQuery = COLLECTION_NOTIFICATIONS
                .document(user.id!).collection("user-notifications")
                .order(by: "timestamp", descending: true)
            
            notificationQuery.getDocuments { snapshot, _ in
                guard let documents = snapshot?.documents else {return}
                
                self.notification = documents.compactMap({ try? $0.data(as: Notification.self)})
                
            }
        } catch {
            print(error.localizedDescription)
        }
        
    }
    
    // TODO: - 매개변수 수정 필요
    /// 알림 업로드하기
     func uploadNotification(/**toUid uid: String,**/type : NotificationType) {
        do {
            let user  = try UserDefaults.standard.getObject(forKey: "User", castTo: User.self)
            
            let notificationData: [String: Any] = ["username" : user.nickname,
                                       "authPicUrl" : "",
                                       "timestamp" : Timestamp(date: Date()),
                                       "type": type.rawValue,
                                       "uid" : user.id ?? ""]
            COLLECTION_NOTIFICATIONS
                .document()
                .collection("user-notifications")
                .addDocument(data: notificationData)
            
        } catch {
            print(error.localizedDescription)
        }
        
    }
    
    // 서버에서 데이터 가져오기
    func fetchUser(withUid uid : String, completion: @escaping (User) -> Void){
        Firestore.firestore().collection("users")
            .document(uid)
            .getDocument { snapshot, _ in
                guard let snapshot = snapshot else {return}
                
                guard let user = try? snapshot.data(as: User.self) else {return}
                completion(user)

            }
    }
    
    
}
