//
//  Saving.swift
//  ToGather
//
//  Created by DaeSeong on 2022/06/08.
//

import Foundation
import Firebase

struct Saving : Codable {
    var goalProduct: Product
    let uid: String
    let goalWeeks: Int // 처음 설정한 목표 저축 기간. ~주
    
    // MARK: 일단 테스트 용으로 값을 입력 받음. 나중에는 자동으로 계산.
    let startDate: String // 첫번째 저축 시작 날짜.
    // var startDate: String {getFirstSavingDate()}

    let savingDayOfTheWeek: String // 저축 요일

    var savingAmountOfWeek: Int {Int(goalProduct.productPrice / Double(goalWeeks))} // 매주 저축해야하는 금액

    var weekInfo: [ThisWeek] // 매주 저축한 것에 대한 정보를 담고있는 배열
    
    var currentWeek: Int = 14 // 저축 회차 << 핵심 변수.
    // var currentWeek: Int { getCurrentWeek(from: startDate) }
    
    /// 저축 실패 횟수
    var totalFailedNum: Int {currentWeek - totalSavedNum}
    
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
