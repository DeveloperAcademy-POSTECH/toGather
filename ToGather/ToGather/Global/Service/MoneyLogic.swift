//
//  MoneyLogic.swift
//  ToGather
//
//  Created by hyo on 2022/06/16.
//

import Foundation

func getSaveAmountOfWeek(productPrice : Double, goalWeek: Int) -> Double {
    return round(productPrice * 10 / Double(goalWeek))/10
}
