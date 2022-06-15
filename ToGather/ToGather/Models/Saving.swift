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
    let uid: String
    let goalWeeks: Int
    let startDate: String // 일단은 더미데이터로 넣고 나중에는 앱 작동하면 현재 날짜로 넣어줘야함.

    let savingDayOfTheWeek: String

    var savingAmountOfWeek: Int {Int(Product.productPrice / Double(goalWeeks))}

    var weekInfo: [ThisWeek]
    
//    var startDate: String {getFirstSavingDate()}
    
    var currentWeek: Int = 14 // { getCurrentWeek(from: startDate) }
    
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
