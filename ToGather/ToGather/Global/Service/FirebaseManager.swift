//
//  FirebaseManager.swift
//  ToGather
//
//  Created by Seungwon Choi on 2022/06/16.
//

import Firebase
import SwiftUI

final class FirebaseManager: ObservableObject {
//    @EnvironmentObject var onboardingViewModel: UserViewModel
    @Published var nicknameArray: [String] = []
    @Published var onboardingViewModel = UserViewModel()
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
    
    func changeViewModel(userViewModel: UserViewModel) {
        onboardingViewModel = userViewModel
    }
}
