//
//  SwiftUIView.swift
//  ToGather
//
//  Created by yudonlee on 2022/06/09.
//

import SwiftUI

enum ColorStyle: String {
    case blue
    case blackHundred
    case blackEighty
    case blackSixty
    case blackTen

    var color: Color {
        switch  self {
        case .blue: return Color(red: 0.439, green: 0.659, blue: 0.969)
        case .blackHundred: return Color(red: 0.169, green: 0.208, blue: 0.247)
        case .blackEighty: return Color(red: 0.169, green: 0.208, blue: 0.247, opacity: 0.8)
        case .blackSixty: return Color(red: 0.169, green: 0.208, blue: 0.247, opacity: 0.6)
        case .blackTen: return Color(red: 0.169, green: 0.208, blue: 0.247, opacity: 0.1)
        }
    }
}

// 사용법
// ColorStyle.blue.color
// ColorStyle.blackTen.color
