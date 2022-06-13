//
//  Saving.swift
//  ToGather
//
//  Created by DaeSeong on 2022/06/08.
//

import Foundation
import Firebase
struct Saving {
    var goalProduct: Product
    var uid: String
    var goalWeeks: Int
    let startDate: Timestamp
    var savingDayOfTheWeek: String
    
    // 파이어베이스에 docoument만들어서 그 안에 Week객체 넣으면 될거같습니다.
    var weekInfo: [ThisWeek]
    
    // ToDo 현재시간과 startDate를 고려해서 계산해야함.
    var currentWeek = 14
    
    var totalSavedNum: Int {
        var currentTotal = 0
        for week in weekInfo[0..<currentWeek] {
            currentTotal += week.didSave ? 1 : 0
        }
        return currentTotal
    }
    
    // %에서 100을 곱해서 나온다.
    var progressPercent: Double { Double(totalSavedNum) / Double(goalWeeks) * 100 }
}
