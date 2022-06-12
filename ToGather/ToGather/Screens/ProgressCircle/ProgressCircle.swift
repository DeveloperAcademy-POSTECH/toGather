//
//  TestCode.swift
//  ToGather
//
//  Created by hyo on 2022/06/09.
//

import SwiftUI

var savePeriod: Int {
    return saveList.count
}

var interval: Double {
    return length/Double(savePeriod)
}

// lineCircle 각도 계산
let start: Double = 0
let end: Double = 0.8
let length = end - start
let rotationDegree = (360 * (1 - length))/2 + 90

struct ProgressCircle: View {
    let color: RGBColorInProgressCircle
    let frameSize: Double // 가장 큰 원의 Frame 사이즈
    
    let weekInfo: [ThisWeek]

    // 나중에 제거, saving으로부터 가져오기
    let currentWeek = 14

    // 나중에 제거, saving으로부터 가져오기
    var totalSavedNum: Int {
        getTotalSavedNum(saveList: weekInfo, currentWeek: currentWeek)
    }

    var gradientIntervalRed: Double {(color.endRed - color.red)/Double(totalSavedNum)}
    var gradientIntervalGreen: Double {(color.endGreen - color.green)/Double(totalSavedNum)}
    var gradientIntervalBlue: Double {(color.endBlue - color.blue)/Double(totalSavedNum)}

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
            ForEach(weekInfo[0..<currentWeek]) { week in
                if week.didSave {
                    let startRed: Double = color.red + gradientIntervalRed * Double(week.id - 1)
                    let endRed: Double = startRed + gradientIntervalRed
                    let startGreen: Double = color.green + gradientIntervalGreen * Double(week.id - 1)
                    let endGreen: Double = startGreen + gradientIntervalGreen
                    let startBlue: Double = color.blue + gradientIntervalBlue * Double(week.id - 1)
                    let endBlue: Double = startBlue + gradientIntervalBlue
                    let startColor = Color(red: startRed, green: startGreen, blue: startBlue)
                    let endColor = Color(red: endRed , green: endGreen, blue: endBlue)

                    let gradientColor = LinearGradient(gradient: Gradient(colors: [startColor, endColor]), startPoint: .bottom, endPoint: .top)

                    Circle()
                        .trim(from: interval * Double(week.id - 1), to: interval * Double(week.id))
                        .stroke(gradientColor, style: lineStyle)
                        .rotationEffect(.init(degrees: rotationDegree))
                }
            }.frame(width: frameSize * 0.9, height: frameSize * 0.9, alignment: .center)
        }
    }
}

struct TestCode_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            ProgressCircle(color: RGBColorInProgressCircle.myColor, frameSize: 330, weekInfo: saveList)
            Spacer()
            Text("전체 주차 \(saveList.count)")
            Text("현재 주차 \(currentWeek)")
        }
    }
}
