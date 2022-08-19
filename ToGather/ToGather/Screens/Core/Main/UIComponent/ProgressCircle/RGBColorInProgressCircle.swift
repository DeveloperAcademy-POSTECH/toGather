//
//  RGBColorInProgressCircle.swift
//  ToGather
//
//  Created by hyo on 2022/06/12.
//

import SwiftUI

struct RGBColorInProgressCircle {
    let red: Double
    let green: Double
    let blue: Double

    let multipleRed = 0.61
    let multipleGreen = 0.62
    let multipleBlue = 0.93

    var endRed: Double {red * multipleRed}
    var endGreen: Double {green * multipleGreen}
    var endBlue: Double {blue * multipleBlue}

    var start: Color {
       return Color(red: red, green: green, blue: blue)
    }

    var end: Color {
       return Color(red: endRed, green: endGreen, blue: endBlue)
    }

    var background: Color {
        return start.opacity(0.05)
    }
    var line: Color {
        return start.opacity(0.20)
    }
}
extension RGBColorInProgressCircle {
    static let colorList: [Color] = [friendColor1, friendColor2, friendColor3]
    static var friendColor1: Color = .friendRed01
    static var friendColor2: Color = .friendPurple01
    static var friendColor3: Color = .friendGreen01
    static var myColor: Color = .pointColor
}

import UIKit

extension Color {
    var components: (red: CGFloat, green: CGFloat, blue: CGFloat) {
        
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var o: CGFloat = 0
        
        guard UIColor(self).getRed(&r, green: &g, blue: &b, alpha: &o) else {
            return (0, 0, 0)
        }
        
        return (r, g, b)
    }
}
