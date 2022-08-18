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
    let color: RGBColorInProgressCircle
    let frameSize: Double // 가장 큰 원의 Frame 사이즈    
    let saving: Saving
    
    var weekInfo: [ThisWeek] {saving.weekInfo}
    
    // 전체 길이 = 기존 goal + 추가 포함
    var savePeriod: Int { saving.totalWeek}
    var interval: Double { length/Double(savePeriod) }
    
    var currentWeek: Int {saving.currentWeek}
    var totalSavedNum: Int {saving.totalSavedNum}

    var gradientIntervalRed: Double {(color.endRed - color.red)/Double(totalSavedNum)}
    var gradientIntervalGreen: Double {(color.endGreen - color.green)/Double(totalSavedNum)}
    var gradientIntervalBlue: Double {(color.endBlue - color.blue)/Double(totalSavedNum)}
    var progressLines: [ProgressLine] { getProgressLines(weekInfo: Array(weekInfo[0..<currentWeek - 1])) }
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

            ForEach(progressLines) { progressLine in
                Circle()
                    .trim(from: interval * Double(progressLine.start), to: interval * Double(progressLine.end))
                    .stroke(.red, style: lineStyle)
                    .rotationEffect(.init(degrees: rotationDegree))
            }.frame(width: frameSize * 0.9, height: frameSize * 0.9, alignment: .center)
        }
    }
    
    struct ProgressLine: Identifiable {
        let start: Int
        let end: Int
        let length: Int
        let id: Int
    }

    func getProgressLines(weekInfo: [ThisWeek]) -> [ProgressLine] {
        var i = 0
        var start = 0
        var length = 0
        var progressLines: [ProgressLine] = []
        var id = 0
        
        while i < weekInfo.count {
            if weekInfo[i].didSave == true {
                start = i
                while weekInfo[i].didSave == true {
                    i += 1
                    length += 1
                    if i == weekInfo.count {
                        progressLines.append(ProgressLine(start: start,  end: start + length, length: length, id: id))
                        id += 1
                        break
                    }
                }
            } else {
                progressLines.append(ProgressLine(start: start, end: start + length, length: length, id: id))
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
            ProgressCircle(color: RGBColorInProgressCircle.myColor, frameSize: 330, saving: DummyData.mySaving)
            Spacer()
//            Text("현재 주차 \(currentWeek)")
        }
    }
}
