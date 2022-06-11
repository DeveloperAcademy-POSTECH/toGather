//
//  CircleProgress.swift
//  ToGather
//
//  Created by DaeSeong on 2022/06/09.
//

import SwiftUI

struct CircleProgress: View {
    let percentage: Double
    let radius: CGFloat
    let gradientColors: [Color]
    let backgroundColor: Color
    let unfillColor: Color
    var body: some View {
        ZStack {
            Circle()
                .trim(from: 0, to: 0.8)
                .rotation(Angle(degrees: 125))
                .stroke(style: StrokeStyle(lineWidth: radius*0.03, lineCap: .round, lineJoin: .round))
                .fill(backgroundColor)
                .padding(.all,radius*0.05)
                .frame(width: radius, height: radius)
            
            Circle()
                .fill(unfillColor)
                .frame(width: radius, height: radius)
                .overlay(Circle()
                    .trim(from: 0, to: 0.8*percentage)
                    .rotation(Angle(degrees: 125))
                    .stroke(style: StrokeStyle(lineWidth: radius*0.03, lineCap: .round, lineJoin: .round))
                    .fill(LinearGradient(colors: gradientColors,
                                         startPoint: UnitPoint(x: 0.5, y: 0.25),
                                         endPoint: UnitPoint(x: 0.5, y: 0.75)))
                    .padding(.all,radius*0.05))
        }
    }
}

struct CircleProgress_Previews: PreviewProvider {
    static var previews: some View {
        CircleProgress(percentage: 0.3,
                       radius: 310,
                       gradientColors: [
                        Color(hex: "#0043A0"),
                        Color(hex: "#5199FF")
                       ],
                       backgroundColor: Color.pointColor.opacity(0.05),
                       unfillColor: Color.pointColor.opacity(0.2))
        
    }
}
