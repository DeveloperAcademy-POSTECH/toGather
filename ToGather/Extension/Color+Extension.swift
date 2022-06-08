//
//  Color+Extension.swift
//  AppleStop
//
//  Created by SHIN YOON AH on 2022/04/07.
//

import SwiftUI

extension Color {
    static var backgroundGrey: Color {
        return Color(hex: "#FBFBFB")
    }
    
    static var lightGrey: Color {
        return Color(hex: "#AAAAAA")
    }
    
    static var mainGreen: Color {
        return Color(hex: "#51AA6F")
    }
    
    static var iconGrey: Color {
        return Color(hex: "#8A8A8A")
    }
    
    static var charOrange: Color {
        return Color(hex: "#F26725")
    }
    
    static var popupGrey: Color {
        return Color(hex: "#8E8E8E")
    }
    
    static var listGrey: Color {
        return Color(hex: "#F2F2F7")
    }
        
    static var chartGrey: Color {
        return Color(hex: "#EFEFEF")
    }
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
