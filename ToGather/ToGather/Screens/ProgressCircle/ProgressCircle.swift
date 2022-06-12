//
//  TestCode.swift
//  ToGather
//
//  Created by hyo on 2022/06/09.
//

import SwiftUI

// 그라데이션 컬러
struct RGBColorInProgressCircle {
    let red: Double
    let green: Double
    let blue: Double

    let multipleRed = 0.61
    let multipleGreen = 0.62
    let multipleBue = 0.93

    var start: Color {
        return Color(red: red, green: green, blue: blue)
    }

    var end: Color {
        return Color(red: red * multipleRed, green: green * multipleGreen, blue: blue * multipleBue)
    }

    var background: Color {
        return start.opacity(0.05)
    }
    var line: Color {
        return start.opacity(0.20)
    }
}

let myColor = RGBColorInProgressCircle(red: 0.44, green: 0.66, blue: 0.97)

var savePeriod: Int {
    return saveList.count
}

var interval: Double {
    return length/Double(savePeriod)
}

var progressPercent: Double = 30

// lineCircle 각도 계산
let start: Double = 0
let end: Double = 0.8
let length = end - start
let rotationDegree = (360 * (1 - length))/2 + 90

struct ProgressCircle: View {
    let color: RGBColorInProgressCircle
    let frameSize: Double // 가장 큰 원의 사이즈

    var body: some View {
        ZStack {
            let lineStyle = StrokeStyle(lineWidth: frameSize * 0.03, lineCap: .round, lineJoin: .round)
            // background circle
            Circle()
                .fill(color.background)
                .frame(width: frameSize, height: frameSize, alignment: .center)

            // background line
            Circle().trim(from: start, to: end)
                .stroke(color.line, style: lineStyle)
                .rotationEffect(.init(degrees: rotationDegree))
                .frame(width: frameSize * 0.9, height: frameSize * 0.9, alignment: .center)

            // progress line
            ForEach(saveList[0..<currentWeek]) { week in
                if week.didSave == true {
                    Circle()
                        .trim(from: interval * Double(week.id - 1), to: interval * Double(week.id))
                        .stroke(color.start, style: lineStyle)
                        .rotationEffect(.init(degrees: rotationDegree))
                }
            }.frame(width: frameSize * 0.9, height: frameSize * 0.9, alignment: .center)
        }
    }
}

struct TestCode_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            ProgressCircle(color: myColor, frameSize: 330)
            Spacer()
            Text("전체 주차 \(saveList.count)")
            Text("현재 주차 \(currentWeek)")
        }
// .background(LinearGradient(gradient: Gradient(colors: [myColor.start, myColor.end]), startPoint: .bottom, endPoint: .top)  )
//        Circle()
//            .trim(from: start, to: end)
//            .stroke(ColorStyle.blue.color, style: StrokeStyle(lineWidth: 8, lineCap: .round, lineJoin: .round))
//            .rotationEffect(.init(degrees: rotationDegree))
    }
}
