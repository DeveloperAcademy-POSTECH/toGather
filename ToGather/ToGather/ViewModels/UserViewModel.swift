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
    
    // MARK: - Properties
    @Published var mode : DisplayMode = .light
    @Published var userData = dummyMy
    @Published var dummyUserData = dummyFriend1
    
    @Published var authPics : [String] = []
    
    @Published var friendNicknames: [String]  = []
    @Published var friendUids: [String] = []
    @Published var friendDatas : [User] = []
    @Published var friendProgressCircles : [FriendProgressCircle] = []
    
    
    // MARK: - Functions
    /// goal-setting 뷰에서 사용, savingData 인스턴스에 목표 product 추가
    func setGoalProduct(product: String) {
        userData.saveInfo.goalProduct = product
    }
    func getGoalProduct() -> String {
        return userData.saveInfo.goalProduct
    }
    /// setting-period 뷰에서 사용, savingData 인스턴스에 총 주차, 요일 추가
    func setGoalPeriod(goalWeeks: Int, dayOfTheWeek: String) {
        userData.saveInfo.goalWeeks = goalWeeks
        userData.saveInfo.savingDayOfTheWeek = dayOfTheWeek
        userData.saveInfo.startDate = getFirstSavingDate(setDay: dayOfTheWeek, appStartDate: dateToString(date: Date()))
    }
    /// friend-addition 뷰에서 사용, friendUids array에 친구 uid 추가
    func setFriendUids(friendUids: [String]) {
        self.friendUids = friendUids
    }
    
    func setFriendNicknames(friendNicknames: [String]) {
        self.friendNicknames = friendNicknames
    }
    
    /// 장비의 uuid를 userData 인스턴스와 savingData 인스턴스에 각각 추가
    func initUid() {
        let uuid = UIDevice.current.identifierForVendor!.uuidString
        let uidIndex = uuid.index(uuid.startIndex, offsetBy: 5)
        userData.id = String(uuid[...uidIndex])
        UserDefaults.standard.set(userData.id, forKey: "User")
    }
    
    ///유저 인증사진들 가져오기
    func requestAuthPics() {
        FirebaseManager.shared.requestAuthPics(userData: userData) { authPics in
            self.authPics = authPics
        }
    }

    /// 친구정보들가져오기
    func requestFriendProgressCircles() {
        if friendUids.isEmpty {
            self.friendUids = userData.friendUids ?? []
        }
        FirebaseManager.shared.requestUsers(userIds: friendUids) { [weak self] friendDatas in
            for i in 0..<friendDatas.count {
                self?.friendProgressCircles.append(FriendProgressCircle(id: i, user: friendDatas[i], color: RGBColorInProgressCircle.colorList[i]))
            }
        }
    }
    
    func uploadUserData() {
        FirebaseManager.shared.uploadUserData(userData: userData, friendUids: friendUids)
    }
    
    
    func launch() {
        self.initUid()
        self.uploadUserData()
        self.requestFriendProgressCircles()
    }
}

