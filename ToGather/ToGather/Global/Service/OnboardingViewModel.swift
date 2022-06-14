//
//  LastOnboardingViewModel.swift
//  ToGather
//
//  Created by Seungwon Choi on 2022/06/09.
//

import Foundation
import Firebase
import UIKit
import SwiftUI

class OnboardingViewModel: ObservableObject {
    @Published var savingData = Saving(goalProduct: Product(productName: "", productPrice: 0, imageUrl: ""),
                                       uid: "", goalWeeks: 0, startDate: Timestamp(date: Date()), savingDayOfTheWeek: "",
                                       weekInfo: [ThisWeek(presentWeek: 0, didSave: false)])
    @Published var userData = User(id: "", nickname: "", creationDate: Date(), isAlarmOn: true)
    
    // goal-setting 뷰에서 사용, savingData 인스턴스에 목표 product 추가
    func addProduct(product: Product) {
        savingData.goalProduct = product
    }
    
    // setting-period 뷰에서 사용, savingData 인스턴스에 총 주차, 요일 추가
    func addGoalWeekAndDayOfTheWeek(goalWeeks: Int, dayOfTheWeek: String) {
        savingData.goalWeeks = goalWeeks
        savingData.savingDayOfTheWeek = dayOfTheWeek
    }
    
    // user 컬렉션에서 friend의 uid로 검색하여 친구 정보 가져오기
    func getFriendInfo(friendUids: [String]){
        let db = Firestore.firestore()
        for friendUid in friendUids {
            let docRef = db.collection("user").document(friendUid)
            
            docRef.getDocument { (document, error) in
                if let document = document, document.exists {
                    let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                        print(dataDescription)
                } else {
                    print("User document does not exist")
                }
            }
        }
    }
    
    // savingData의 friend 인스턴스의 uid만 추출하여 array 만들기 (firebase 업로드용)
//    func makeFriendUidArray(friends: [User]) -> [String] {
//        var friendUidArray: [String]
//
//        for friend in friends {
//            friendUidArray.append(friend.id ?? "")
//        }
//
//        return friendUidArray
//    }
    
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
//            "friends": makeFriendUidArray(friends: userData.friends ?? [])
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
            "savingDayOfTheWeek": savingData.savingDayOfTheWeek,
//            "productId": savingData.goalProduct.id
        ]) { err in
            if let err = err {
                print("Error writing saving document: \(err)")
            } else {
                print("Saving document successfully written!")
            }
        }
    }
}
