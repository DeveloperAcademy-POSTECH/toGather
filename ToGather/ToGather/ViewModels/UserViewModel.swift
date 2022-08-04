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
    @Published var friendNicknames: [String]  = []
    @Published var mode : DisplayMode = .light
    @Published var userData = dummyMy
    @Published var dummyUserData = dummyFriend1
    @Published var friendUids: [String] = []
    @Published var authPics : [String] = []
    @Published var friendDatas : [User] = []
    @Published var friendsList : [FriendsProgressCircle] = []


    // MARK: - Functions
    /// goal-setting 뷰에서 사용, savingData 인스턴스에 목표 product 추가
    func addProduct(product: String) {
        userData.saveInfo.goalProduct = product
    }
    func getProduct() -> String {
        return userData.saveInfo.goalProduct
    }
    /// setting-period 뷰에서 사용, savingData 인스턴스에 총 주차, 요일 추가
    func addGoalWeekAndDayOfTheWeek(goalWeeks: Int, dayOfTheWeek: String) {
        userData.saveInfo.goalWeeks = goalWeeks
        userData.saveInfo.savingDayOfTheWeek = dayOfTheWeek
        userData.saveInfo.startDate = getFirstSavingDate(setDay: dayOfTheWeek, appStartDate: dateToString(date: Date()))
    }
    /// friend-addition 뷰에서 사용, friendUids array에 친구 uid 추가
    func setFriendUids(friendUids str: [String]) {
        self.friendUids = str
    }
    
    func setFriendNicknames(friendNicknames str: [String]) {
        self.friendNicknames = str
    }
    /// 친구정보리스트  로컬에 가져와 저장하기
    func getFriendList() {
        for i in 0..<friendDatas.count {
            friendsList.append(FriendsProgressCircle(id: i, user: friendDatas[i], color: RGBColorInProgressCircle.colorList[i]))
        }
    }
    
    
    /// 장비의 uuid를 userData 인스턴스와 savingData 인스턴스에 각각 추가
    func addUid() {
        let uuid = UIDevice.current.identifierForVendor!.uuidString
        let uidIndex = uuid.index(uuid.startIndex, offsetBy: 5)
        userData.id = String(uuid[...uidIndex])
 //       print("addUid: \(userData.id ?? "")")
        UserDefaults.standard.set(userData.id,forKey: "User")
    }
    
    ///유저 인증사진들 가져오기
    func fetchAuthPics() {
            FirebaseManager.shared.requestAuthPics(userData: userData) { authPics in
                    self.authPics = authPics
                print(authPics)

            }
    }
    /// 유저정보가져오기
    func fetchUser(userId : String) {
        FirebaseManager.shared.fetchUser(userId: userId) { user in
           userViewModel.userData = user
        }
    }
    /// 친구정보들가져오기
    func fetchfriends() {
        if friendUids.isEmpty {
            self.friendUids = userData.friendUids ?? []
        }
        FirebaseManager.shared.fetchUsers(userIds: friendUids) { [weak self] friendDatas in
            for i in 0..<friendDatas.count {
                self?.friendsList.append(FriendsProgressCircle(id: i, user: friendDatas[i], color: RGBColorInProgressCircle.colorList[i]))
            }
        }
    }
    
    func uploadUser() {
        FirebaseManager.shared.uploadUserData(userData: userData, friendUids: friendUids)
    }

}

