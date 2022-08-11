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
    //    @Published var userData = dummy.my
    @Published var userData = User(id: "0", nickname: "Miller", creationDate: "", isAlarmOn: false)
    
    @Published var authPics : [String] = []
    @Published var authPicsDate: [String] = []
    @Published var authPicsDateDiff: [String] = []
    
    @Published var friendNicknames: [String]  = []
    @Published var friendUids: [String] = []
    @Published var friendDatas : [User] = []
    @Published var friendProgressCircles : [FriendProgressCircle] = []
    
    
    // MARK: - Functions
    /// goal-setting 뷰에서 사용, savingData 인스턴스에 목표 product 추가
    func setGoalProduct(product: String) {
        userData.saveInfo.goalProduct = product
    }
    /// goalProduct 가져오기
    func getGoalProduct() -> String {
        return userData.saveInfo.goalProduct
    }
    
    /// setting-period 뷰에서 사용, savingData 인스턴스에 총 주차, 요일 추가
    func setGoalPeriod(goalWeeks: Int, dayOfTheWeek: String) {
        userData.saveInfo.goalWeeks = goalWeeks
        userData.saveInfo.savingDayOfTheWeek = dayOfTheWeek
        userData.saveInfo.startDate = getFirstSavingDate(setDay: dayOfTheWeek, appStartDate: dateToString(date: Date()))
    }
    
    /// friend-addition 뷰에서 사용, friendUids array에 친구들 uid 추가
    func setFriendUids(friendUids: [String]) {
        self.friendUids = friendUids
    }
    
    /// friend-addition 뷰에서 사용, friendUids array에 친구들 닉네임추가
    func setFriendNicknames(friendNicknames: [String]) {
        self.friendNicknames = friendNicknames
    }
    
    /// 장비의 uuid를 userData 인스턴스와 savingData 인스턴스에 각각 추가
    func initUid() {
        let uuid = UIDevice.current.identifierForVendor!.uuidString
        let uidIndex = uuid.index(uuid.startIndex, offsetBy: 5)
        userData.id = String(uuid[...uidIndex])
        userData.nickname = String(uuid[...uidIndex]) // FIXME: - 이후 수정
        UserDefaults.standard.set(userData.id, forKey: "User")
    }
    
    ///유저 인증사진들 가져오기
    func requestAuthPics() {
        FirebaseManager.shared.requestAuthPics(userData: userData) { [weak self] result in
            self?.authPics = result.pics
            self?.authPicsDate = result.picsDate
            self?.calculateImageDate()
        }
    }
    
    /// 친구정보들 가져오기
    func requestFriendProgressCircles() {
        if friendUids.isEmpty {
            self.friendUids = userData.friendUids ?? []
        }
        FirebaseManager.shared.requestUsers(userIds: friendUids) { friendDatas in
            DispatchQueue.main.async { [weak self] in
                for i in 0..<friendDatas.count {
                    self?.friendProgressCircles.append(FriendProgressCircle(id: i, user: friendDatas[i], color: RGBColorInProgressCircle.colorList[i]))
                }
            }
        }
    }
    
    /// 유저데이터 업로드하기
    func uploadUserData() {
        FirebaseManager.shared.uploadUserData(userData: userData, friendUids: friendUids)
    }
    
    /// 초기세팅하기
    func launch() {
        self.initUid()
        self.uploadUserData()
        self.requestFriendProgressCircles()
    }
    
    func resetData() {
        userViewModel.friendUids = []
        userViewModel.friendDatas = []
        userViewModel.friendNicknames = []
        userViewModel.friendProgressCircles = []
        userViewModel.userData = DummyData.my
    }
    
    func calculateImageDate() {
        let nowStr = dateToString(date: Date())
        let currentDate = stringToDate(date: nowStr)
        
        var dateDiff: [String] = []
        authPicsDate.forEach { element in
            let created = stringToDate(date: element)
            let diff = Calendar.current.dateComponents([.day, .weekOfYear], from: created, to: currentDate)
            
            if let week = diff.weekOfYear, let day = diff.day {
                if week != 0 {
                    dateDiff.append("\(week)주전")
                } else {
                    dateDiff.append(day == 0 ? "오늘" : "\(day)일전")
                }
            }
            
        }
        
        authPicsDateDiff = dateDiff
        
    }
}
