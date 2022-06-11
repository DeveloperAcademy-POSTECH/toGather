//
//  SwiftUIView.swift
//  ToGather
//
//  Created by yudonlee on 2022/06/09.
//

import SwiftUI

extension Color{
    
    //MARK: 앱 테마색
    static let pointColor = Color("PointColor_blue")
    
    static let basicBlack = Color("BasicBlack")
    
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
