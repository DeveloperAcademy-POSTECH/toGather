//
//  Saving.swift
//  ToGather
//
//  Created by DaeSeong on 2022/06/08.
//

import Foundation
import Firebase

struct Saving : Codable {
    
    var goalProduct: String
//    let uid: String
    var goalWeeks: Int // 처음 설정한 목표 저축 기간. ~주
    
    var startDate: String // 첫번째 저축 시작 날짜.

    var savingDayOfTheWeek: String // 저축 요일

    var weekInfo: [ThisWeek] // 매주 저축한 것에 대한 정보를 담고있는 배열
    
    /// 유저용
    init(goalProduct: String, goalWeeks: Int, savingDayOfTheWeek: String) {
        self.goalProduct = goalProduct
        self.goalWeeks = goalWeeks
        self.savingDayOfTheWeek = savingDayOfTheWeek
        self.startDate = getFirstSavingDate(setDay: savingDayOfTheWeek, appStartDate: dateToString(date: Date()))
        
        self.weekInfo = [ThisWeek]()
        for week in 1...goalWeeks {
            self.weekInfo.append(ThisWeek(presentWeek: week, didSave: false))
        }
    }
    
//    func creatWeekInfo() {
//        var weekInfo: [ThisWeek]
//        let maxGoalWeeks = self.goalWeeks * 2
//        for week in 1...maxGoalWeeks {
//            weekInfo.append(ThisWeek(presentWeek: week, didSave: false))
//        }
//        self.weekInfo = weekInfo
//    }
    
    /// 더미데이터용
    init(goalProduct: String, goalWeeks: Int, savingDayOfTheWeek: String, weekInfo: [ThisWeek], appStartDate: String) {
        self.goalProduct = goalProduct
        self.goalWeeks = goalWeeks
        self.savingDayOfTheWeek = savingDayOfTheWeek
        self.startDate = getFirstSavingDate(setDay: savingDayOfTheWeek, appStartDate: appStartDate)
        self.weekInfo = weekInfo
    }
    
    var currentWeekEndDate: Date {getCurrentWeekEndDate(currentWeek: currentWeek, firstSavingDate: startDate)}
    
    var deadLine: String {getRemainTime(currentWeekEndDate: currentWeekEndDate)}
    
    var lastDate: String {getLastSavingDate(firstSavingDate: startDate, totalWeek: totalWeek)}
        
    /// 매주 저축해야하는 금액
    var savingAmountOfWeek: Double {getSaveAmountOfWeek(productPrice:  Product.productDictionary[ goalProduct]?.productPrice ?? 0, goalWeek: goalWeeks)}
    
    /// 목표 저축 금액(전체)
    var goalSavingAmount: Double {savingAmountOfWeek * Double(goalWeeks)}
    
    /// 현재까지 전체 저축 금액
    var totalSavingAmount: Double {savingAmountOfWeek * Double(totalSavedNum)}
    
//    var isSavedCurrentWeek: Bool {weekInfo[currentWeek - 1].didSave == true}
    
    /// 저축 회차 << 핵심 변수.
    var currentWeek: Int { getCurrentWeek(from: startDate, weekInfo: weekInfo) }
    
    /// 전체 기간
    var totalWeek: Int {totalFailedNum + goalWeeks}
    
    /// 저축 실패 횟수
    var totalFailedNum: Int {currentWeek - totalSavedNum - 1}
    
    /// 저축 성공 횟수
    var totalSavedNum: Int {
        var currentTotal = 0
        for week in weekInfo[0..<currentWeek] {
            currentTotal += week.didSave ? 1 : 0
        }
        return currentTotal
    }
    
    /// %에서 100을 곱한 값. 값이 30이면 30%라는 의미
    var progressPercent: Double { Double(totalSavedNum) / Double(goalWeeks) * 100 }
}

extension Saving {
    func canSaving() -> Bool {
        return isSavingDay(currentWeekEndDate: self.currentWeekEndDate)
    }
}
