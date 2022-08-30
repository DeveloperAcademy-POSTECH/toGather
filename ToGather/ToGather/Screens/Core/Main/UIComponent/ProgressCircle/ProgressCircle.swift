//
//  TestCode.swift
//  ToGather
//
//  Created by hyo on 2022/06/09.
//

import SwiftUI

// lineCircle 각도 계산
let start: Double = 0
let end: Double = 0.8
let length = end - start

let rotationDegree = (360 * (1 - length))/2 + 90

struct ProgressCircle: View {
    let color: Color
    let frameSize: Double // 가장 큰 원의 Frame 사이즈    
    let saving: Saving
    
    var weekInfo: [ThisWeek] {saving.weekInfo}
    
    // 전체 길이 = 기존 goal + 추가 포함
    var savePeriod: Int { saving.totalWeek }
    var interval: Double { length / Double(savePeriod) }
    
    var currentWeek: Int { saving.currentWeek }
    var totalSavedNum: Int { saving.totalSavedNum }

    var progressLines: [ProgressLine] { getProgressLines(weekInfo: Array(weekInfo[0..<currentWeek - 1])) }
    
    var body: some View {
        ZStack {
            let lineStyle = StrokeStyle(lineWidth: frameSize * 0.03, lineCap: .round, lineJoin: .round)
            // background circle
            Circle()
                .fill(color.opacity(0.05))
                .frame(width: frameSize, height: frameSize, alignment: .center)

            // background line
            Circle().trim(from: start, to: end)
                .stroke(color.opacity(0.2), style: lineStyle)
                .rotationEffect(.init(degrees: rotationDegree))
                .frame(width: frameSize * 0.9, height: frameSize * 0.9, alignment: .center)

            ForEach(progressLines) { progressLine in
                let startColor = ProgressCircle.getColorForGradient(color: color, alpha: Double(progressLine.startColorPoint) / Double(totalSavedNum))
                let endColor = ProgressCircle.getColorForGradient(color: color, alpha: Double(progressLine.endColorPoint) / Double(totalSavedNum))
                let gradientColor = AngularGradient(gradient: Gradient(colors: [startColor, endColor]), center: .center, startAngle: .degrees( interval * Double(progressLine.start) * 360), endAngle: .degrees( interval * Double(progressLine.end) * 360))

                Circle()
                    .trim(from: interval * Double(progressLine.start), to: interval * Double(progressLine.end))
                    .stroke(gradientColor, style: lineStyle)
                    .rotationEffect(.init(degrees: rotationDegree))
                
            }.frame(width: frameSize * 0.9, height: frameSize * 0.9, alignment: .center)
        }
    }
    
    struct ProgressLine: Identifiable {
        let start: Int
        let length: Int
        let id: Int
        let startColorPoint: Int
        
        var end: Int {start + length}
        var endColorPoint: Int { startColorPoint + length }
    }
    
    
    static func getColorForGradient(color : Color, alpha: Double) -> Color {
        let multipleRed = 0.61
        let multipleGreen = 0.62
        let multipleBlue = 0.93
        
        let red = Double(color.components.red)
        let green = Double(color.components.green)
        let blue = Double(color.components.blue)
        
        func temp(color: Double, multi: Double, alpha: Double) -> Double {
            let endColor = color * multi
            let returnColor = color + (endColor - color) * alpha
            return returnColor
        }
        
        let returnRed = temp(color: red, multi: multipleRed, alpha: alpha)
        let returnGreen = temp(color: green, multi: multipleGreen, alpha: alpha)
        let returnBlue = temp(color: blue, multi: multipleBlue, alpha: alpha)

        return Color(red: returnRed, green: returnGreen, blue: returnBlue)
    }
    
    func getProgressLines(weekInfo: [ThisWeek]) -> [ProgressLine] {
        var i = 0
        var start = 0
        var length = 0
        var progressLines: [ProgressLine] = []
        var id = 0
        var startColorPoint = 0
        while i < weekInfo.count {
            if weekInfo[i].didSave == true {
                start = i
                while weekInfo[i].didSave == true {
                    i += 1
                    length += 1
                    if i == weekInfo.count {
                        progressLines.append(ProgressLine(start: start, length: length, id: id, startColorPoint: startColorPoint))
                        id += 1
                        break
                    }
                }
            } else {
                progressLines.append(ProgressLine(start: start, length: length, id: id, startColorPoint: startColorPoint))
                startColorPoint += length
                id += 1
                length = 0
                while weekInfo[i].didSave == false {
                    i += 1
                    if i == weekInfo.count {
                        break
                    }
                }
            }
        }
        return progressLines
    }
}

struct TestCode_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            ProgressCircle(color: .pointColor, frameSize: 330, saving: DummyData.mySaving)
        }
    }
}
