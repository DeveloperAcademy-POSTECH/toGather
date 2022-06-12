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

    var start: Color {
        return Color(red: red, green: green, blue: blue)
    }

    var end: Color {
        return Color(red: red * multipleRed, green: green * multipleGreen, blue: blue * multipleBlue)
    }

    var background: Color {
        return start.opacity(0.05)
    }
    var line: Color {
        return start.opacity(0.20)
    }
}
