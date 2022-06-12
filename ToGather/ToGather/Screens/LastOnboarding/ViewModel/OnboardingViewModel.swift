//
//  LastOnboardingViewModel.swift
//  ToGather
//
//  Created by Seungwon Choi on 2022/06/09.
//

import Foundation
import Firebase
import UIKit

class OnboardingViewModel: ObservableObject {
    @Published var savingData = Saving(goalProduct: "", uid: "", goalWeeks: 0, startDate: Date(), savingDayOfTheWeek: "")
    @Published var userData = User(id: "", nickname: "", creationDate: Date(), isAlarmOn: true, friends: [])
    
    // savingData 인스턴스에 목표 product 추가
    func addProduct(product: String) {
        savingData.goalProduct = product
    }
    
    // savingData 인스턴스에 총 주차, 요일 추가
    func addGoalWeekAndDayOfTheWeek(goalWeeks: Int, dayOfTheWeek: String) {
        savingData.goalWeeks = goalWeeks
        savingData.savingDayOfTheWeek = dayOfTheWeek
    }
    
    // userData 인스턴스에 친구 추가
    func addFriend(friendUid: String) {
        userData.friends.append(friendUid)
    }
    
    // 장비의 uuid를 userData 인스턴스와 savingData 인스턴스에 각각 추가
    func addUid() {
        let uuid = UIDevice.current.identifierForVendor!.uuidString
        let uidIndex = uuid.index(uuid.startIndex, offsetBy: 5)
        userData.id = String(uuid[...uidIndex])
        savingData.uid = userData.id ?? ""
    }
    
    // firebase에 savingData 인스턴스와 userData 인스턴스 업로드
    func uploadSavingDataAndUserData() {
        let db = Firestore.firestore()
        
        // user 컬렉션에 userData 인스턴스 업로드
        db.collection("user").document(userData.id ?? "").setData([
            "id": userData.id ?? "",
            "creationDate": Date(),
            "isAlarmOn": true,
            "friends": userData.friends
        ]) { err in
            if let err = err {
                print("Error writing user document: \(err)")
            } else {
                print("User document successfully written!")
            }
        }
        
        // saving 컬렉션에 savingData 인스턴스 업로드
        db.collection("saving").addDocument(data: [
            "uid": savingData.uid,
            "goalWeeks": savingData.goalWeeks,
            "startDate": Date(), // startDate 계산법 현재 미구현
            "savingDayOfTheWeek": savingData.savingDayOfTheWeek
        ]) { err in
            if let err = err {
                print("Error writing saving document: \(err)")
            } else {
                print("Saving document successfully written!")
            }
        }
    }
}
