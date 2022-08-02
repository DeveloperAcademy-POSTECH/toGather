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
    static let colorList: [RGBColorInProgressCircle] = [friendColor1, friendColor2, friendColor3]
    static var friendColor1 = RGBColorInProgressCircle(red: 0.91, green: 0.43, blue: 0.54)
    static var friendColor2 = RGBColorInProgressCircle(red: 0.74, green: 0.58, blue: 0.91)
    static var friendColor3 = RGBColorInProgressCircle(red: 0.47, green: 0.83, blue: 0.32)
    static var myColor = RGBColorInProgressCircle(red: 0.44, green: 0.66, blue: 0.97)
}
