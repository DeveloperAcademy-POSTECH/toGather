//
//  LastOnboardingViewModel.swift
//  ToGather
//
//  Created by Seungwon Choi on 2022/06/09.
//

import Firebase
import SwiftUI
import UIKit

final class UserViewModel: ObservableObject {
    @Published var userData = User(id: "", nickname: "", creationDate: "", isAlarmOn: true,
                                   saveInfo: Saving(goalProduct: Product(productName: "airpodsPro", productPrice: 30, imageUrl: "airpodsPro"),
                                                    goalWeeks: 1, startDate: "", savingDayOfTheWeek: "", weekInfo: [ThisWeek]()))
    @Published var friendUids: [String] = []
    
    @Published var friendNickname: [String]  = []
    
    /// goal-setting 뷰에서 사용, savingData 인스턴스에 목표 product 추가
    func addProduct(product: Product) {
        userData.saveInfo.goalProduct = product
    }
    
    func getProduct() -> Product {
        return userData.saveInfo.goalProduct
    }
    
    /// setting-period 뷰에서 사용, savingData 인스턴스에 총 주차, 요일 추가
    func addGoalWeekAndDayOfTheWeek(goalWeeks: Int, dayOfTheWeek: String) {
        userData.saveInfo.goalWeeks = goalWeeks
        userData.saveInfo.savingDayOfTheWeek = dayOfTheWeek
    }
    
    /// friend-addition 뷰에서 사용, friendUids array에 친구 uid 추가
    func getFriendUid(friendUids: [String]) {
        self.friendUids = friendUids
    }
    
    /// 장비의 uuid를 userData 인스턴스와 savingData 인스턴스에 각각 추가
    func addUid() {
        let uuid = UIDevice.current.identifierForVendor!.uuidString
        let uidIndex = uuid.index(uuid.startIndex, offsetBy: 5)
        userData.id = String(uuid[...uidIndex])
    }
    
    func nicknameUpgrade(str : [String]) {
        if !str.isEmpty {
            friendNickname = str
        }
    }
}
