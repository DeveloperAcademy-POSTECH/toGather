//
//  SwiftUIView.swift
//  ToGather
//
//  Created by yudonlee on 2022/06/09.
//

import SwiftUI

extension Color{
    
    // MARK: 포인트 컬러
    static let pointColor = Color("pointColor")
    static let pointColor02 = Color("pointColor02")
    static let pointColor03 = Color("pointColor03")
    
    // MARK: 블랙 컬러 - 02=opacity 60%, 03=opacity 30%, 04=opacity 10%, 05=opacity 5%
    static let basicBlack = Color("basicBlack")
    static let black02 = Color("black02")
    static let black03 = Color("black03")
    static let black04 = Color("black04")
    static let black05 = Color("black05")
    
    // MARK: 친구컬러
    //친구 색 레드 01=100%, 02=20%, 03=5%
    static let friendRed01 = Color("friendRed01")
    static let friendRed02 = Color("friendRed02")
    static let friendRed03 = Color("friendRed03")
    
    //친구 색 퍼플 01=100%, 02=20%, 03=5%
    static let friendPurple01 = Color("friendPurple01")
    static let friendPurple02 = Color("friendPurple02")
    static let friendPurple03 = Color("friendPurple03")
    
    //친구 색 그린 01=100%, 02=20%, 03=5%
    static let friendGreen01 = Color("friendGreen01")
    static let friendGreen02 = Color("friendGreen02")
    static let friendGreen03 = Color("friendGreen03")
    
    //alert 색
    static let alertRed = Color("alertRed")
    static let alertBg = Color("alertBg")
    
    // Background Color
    
    
    
    
    
    
    
    static let basicRed = Color(hex:"#E96E89")
    static let basicPurple = Color(hex:"#BC93E9")
    static let basicGreen = Color(hex:"#77D451")
}



extension Color {
    init(hex: String) {
        var hexFormatted: String = hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
        
        if hexFormatted.hasPrefix("#") {
            hexFormatted = String(hexFormatted.dropFirst())
        }
        assert(hexFormatted.count == 6, "Invalid hex code used.")
        var rgbValue: UInt64 = 0
        Scanner(string: hexFormatted).scanHexInt64(&rgbValue)
        self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                  green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                  blue: CGFloat(rgbValue & 0x0000FF) / 255.0)
    }
}
