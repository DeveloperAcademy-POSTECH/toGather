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
                                   saveInfo: Saving(goalProduct: Product(productName: "", productPrice: 0, imageUrl: ""),
                                                    goalWeeks: 1, startDate: "", savingDayOfTheWeek: "월", weekInfo: [ThisWeek]()))
    @Published var friendUids: [String] = []
    
    /// goal-setting 뷰에서 사용, savingData 인스턴스에 목표 product 추가
    func addProduct(product: Product) {
        userData.saveInfo.goalProduct = product
    }
    
    /// setting-period 뷰에서 사용, savingData 인스턴스에 총 주차, 요일, 저축 시작 날짜 추가
    func addGoalWeekAndDayOfTheWeek(goalWeeks: Int, dayOfTheWeek: String) {
        userData.saveInfo.goalWeeks = goalWeeks
        userData.saveInfo.savingDayOfTheWeek = dayOfTheWeek
        userData.saveInfo.startDate = getFirstSavingDate(setDay: dayOfTheWeek, appStartDate: dateToString(date: Date()))
    }
    
    /// friend-addition 뷰에서 사용, friendUids array에 친구 uid 추가
    func getFriendUid(friendUids: [String]) {
        self.friendUids = friendUids
        FirebaseManager.shared.fetchFriendNickname(friendUids: friendUids)
    }
    
    /// 장비의 uuid를 userData 인스턴스와 savingData 인스턴스에 각각 추가
    func addUid() {
        let uuid = UIDevice.current.identifierForVendor!.uuidString
        let uidIndex = uuid.index(uuid.startIndex, offsetBy: 5)
        userData.id = String(uuid[...uidIndex])
        
//        UserDefaults.standard.set(uidIndex,forKey: "User")
    }
    /// 유저의 정보
    func fetchUser() {
        guard let uid = UserDefaults.standard.string(forKey: "User") else { return}
        FirebaseManager.shared.fetchUser(withUid: uid) { user in
            self.userData = user
        }

    }
}
