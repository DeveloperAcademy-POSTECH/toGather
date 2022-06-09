//
//  Saving.swift
//  ToGather
//
//  Created by DaeSeong on 2022/06/08.
//

import Foundation

struct Saving {
    var goalProduct: Product
    let uid: String
    let totalWeeks: Int
    let startDate: Date
    let savingDayOfTheWeek: String
    
    // 파이어베이스에 docoument만들어서 그 안에 Week객체 넣으면 될거같습니다.
}
