////
////  LastOnboardingViewModel.swift
////  ToGather
////
////  Created by Seungwon Choi on 2022/06/09.
////
//
//import Firebase
//import SwiftUI
//import UIKit
//
//final class OnboardingViewModel: ObservableObject {
//    @Published var savingData = Saving(goalProduct: Product(productName: "", productPrice: 0, imageUrl: ""),
//                                       uid: "", goalWeeks: 0, startDate: Timestamp(date: Date()), savingDayOfTheWeek: "",
//                                       weekInfo: [ThisWeek(presentWeek: 0, didSave: false)])
//    @Published var userData = User(id: "", nickname: "", creationDate: Timestamp(date: Date()), isAlarmOn: true)
//    @Published var friendUids: [String] = []
//
//    /// goal-setting 뷰에서 사용, savingData 인스턴스에 목표 product 추가
//    func addProduct(product: Product) {
//        savingData.goalProduct = product
//    }
//
//    /// setting-period 뷰에서 사용, savingData 인스턴스에 총 주차, 요일 추가
//    func addGoalWeekAndDayOfTheWeek(goalWeeks: Int, dayOfTheWeek: String) {
//        savingData.goalWeeks = goalWeeks
//        savingData.savingDayOfTheWeek = dayOfTheWeek
//    }
//
//    /// friend-addition 뷰에서 사용, friendUids array에 친구 uid 추가
//    func getFriendUid(friendUids: [String]) {
//        self.friendUids = friendUids
//    }
//
//    /// 장비의 uuid를 userData 인스턴스와 savingData 인스턴스에 각각 추가
//    func addUid() {
//        let uuid = UIDevice.current.identifierForVendor!.uuidString
//        let uidIndex = uuid.index(uuid.startIndex, offsetBy: 5)
//        userData.id = String(uuid[...uidIndex])
//        savingData.uid = userData.id ?? ""
//    }
//
//    /// firebase에 savingData 인스턴스와 userData 인스턴스 업로드
//    func uploadSavingDataAndUserData() {
//        let firestore = Firestore.firestore()
//
//        // user 컬렉션에 userData 인스턴스 업로드
//        firestore.collection("user").document(userData.id ?? "").setData([
//            "id": userData.id ?? "",
//            "creationDate": Date(),
//            "isAlarmOn": true,
//            "friends": friendUids
//        ]) { err in
//            if let err = err {
//                print("Error writing user document: \(err)")
//            } else {
//                print("User document successfully written!")
//            }
//        }
//
//        // saving 컬렉션에 savingData 인스턴스 업로드
//        firestore.collection("saving").addDocument(data: [
//            "uid": savingData.uid,
//            "goalWeeks": savingData.goalWeeks,
//            "startDate": Date(), // startDate 계산법 현재 미구현
//            "savingDayOfTheWeek": savingData.savingDayOfTheWeek,
////            "productId": savingData.goalProduct.id
//        ]) { err in
//            if let err = err {
//                print("Error writing saving document: \(err)")
//            } else {
//                print("Saving document successfully written!")
//            }
//        }
//    }
//}
