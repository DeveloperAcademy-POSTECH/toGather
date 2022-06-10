//
//  TestCode.swift
//  ToGather
//
//  Created by hyo on 2022/06/09.
//

import SwiftUI

// 그라데이션 컬러
let startColor: Color = Color(red: 0.439, green: 0.659, blue: 0.969, opacity: 0.05)
let endColor: Color = Color(red: 0.439, green: 0.659, blue: 0.969, opacity: 0.05)

// 더미데이터
struct Week: Identifiable {
    let id: Int
    let check: Int
}

let saveList: [Week] = [Week(id: 1, check: 1), Week(id: 2, check: 1), Week(id: 3, check: 1), Week(id: 4, check: 0), Week(id: 5, check: 1),
                        Week(id: 6, check: 1), Week(id: 7, check: 1), Week(id: 8, check: 1), Week(id: 9, check: 0), Week(id: 10, check: 1),
                        Week(id: 11, check: 1), Week(id: 12, check: 0), Week(id: 13, check: 0), Week(id: 14, check: 0), Week(id: 15, check: 1),
                        Week(id: 16, check: 1), Week(id: 17, check: 0), Week(id: 18, check: 1), Week(id: 19, check: 0), Week(id: 20, check: 1),
                        Week(id: 21, check: 1), Week(id: 22, check: 1), Week(id: 23, check: 1), Week(id: 24, check: 0), Week(id: 25, check: 1)]

let start: Double = 0
let end: Double = 0.8
let length = end - start
let rotationDegree = (360 * (1 - length))/2 + 90

let currentWeek = 14

var savePeriod: Int {
    return saveList.count
}

var interval: Double {
    return length/Double(savePeriod)
}

var progress: Double = 30

struct ProgressCircle: View {
    var body: some View {
        VStack {

            ZStack {
                let lineStyle = StrokeStyle(lineWidth: 8, lineCap: .round, lineJoin: .round)
                // background circle
                Circle()
                    .fill(Color(red: 0.439, green: 0.659, blue: 0.969, opacity: 0.05))
                    .frame(width: 330, height: 330, alignment: .center)

                // background line
                Circle().trim(from: start, to: end)
                    .stroke(Color(red: 0.439, green: 0.659, blue: 0.969, opacity: 0.20), style: lineStyle)
                    .rotationEffect(.init(degrees: rotationDegree))
                    .frame(width: 300, height: 300, alignment: .center)

                // progress line
                ForEach(saveList[0..<currentWeek]) { week in
                    if week.check == 1 {
                        Circle()
                            .trim(from: interval * Double(week.id - 1), to: interval * Double(week.id))
                            .stroke(ColorStyle.blue.color, style: lineStyle)
                            .rotationEffect(.init(degrees: rotationDegree))
                    }
                }.frame(width: 300, height: 300, alignment: .center)
                itemInfo
            }
            Spacer()
            Text("전체 주차 \(saveList.count)")
            Text("현재 주차 \(currentWeek)")
        }
    }
    
    let itemInfo: some View = VStack {
        Spacer(minLength: 250)
        Image(product.imageUrl)
            .resizable()
            .scaledToFit()
            .frame(width: 87, height: 78)
        Text("\(product.productPrice, specifier: "%3.f")만원까지")
            .font(.system(size: 16, weight: .medium))
            .foregroundColor(ColorStyle.blackHundred.color)
            .opacity(0.6)

        Text("\(progress, specifier: "%3.f")%")
            .font(.system(size: 60, weight: .bold))
            .foregroundColor(ColorStyle.blue.color)
        Spacer(minLength: 10)
        VStack {
            Text("저축 완료일")
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(ColorStyle.blackHundred.color)
                .opacity(0.4)
            Text("2022.09.03")
                .font(.system(size: 16, weight: .bold))
                .foregroundColor(ColorStyle.blackHundred.color)
        }
        Spacer(minLength: 220)
    }
}

struct TestCode_Previews: PreviewProvider {
    static var previews: some View {
        ProgressCircle()
//        Circle()
//            .trim(from: start, to: end)
//            .stroke(ColorStyle.blue.color, style: StrokeStyle(lineWidth: 8, lineCap: .round, lineJoin: .round))
//            .rotationEffect(.init(degrees: rotationDegree))
    }
}
