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

/// 만원 단위의 Double 타입 값을 넣어주면 콤마 넣어서 전체 숫자 반환 ex) 10 -> 100,000
func numberFormatUnitOfManwon(value: Double) -> String {
    let numberFormatter = NumberFormatter()
    numberFormatter.numberStyle = .decimal    
    return numberFormatter.string(from: NSNumber(value: Int(value * 10000))) ?? "error"
}
