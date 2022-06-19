//
//  myProgressCircle.swift
//  ToGather
//
//  Created by hyo on 2022/06/12.
//

import SwiftUI

struct MyProgressCircle: View {
    
    let user: User

    var saving: Saving {user.saveInfo}
    var productImageUrl: String {user.saveInfo.goalProduct.imageUrl}
    var productPrice: Double {user.saveInfo.goalProduct.productPrice}
    var progressPercent: Double {user.saveInfo.progressPercent}
    var lastDate: String {user.saveInfo.lastDate}
    var goalWeeks: Int {user.saveInfo.goalWeeks}
    var totalFailedNum: Int = 1 // {user.saveInfo.totalFailedNum}

    let lineStyle = StrokeStyle(lineWidth: 330 * 0.03, lineCap: .round, lineJoin: .round)
    
    let start: CGFloat = 0
    var end: CGFloat {(0.8/Double(goalWeeks)) * Double(totalFailedNum)}
    
    var body: some View {
        ZStack {
            outCircle
            ProgressCircle(color: RGBColorInProgressCircle.myColor, frameSize: 330, saving: saving)
            itemInfo
            weekInfo.offset(x: 115, y: 163)
        }
    }
}

extension MyProgressCircle {
    
    var outCircle: some View {
        Circle().trim(from: 0.8 - end, to: 0.8)
            .stroke(Color.alertRed, style: lineStyle)
            .rotationEffect(.init(degrees: rotationDegree))
            .frame(width: 330 * 1.1, height: 330 * 1.1, alignment: .center)
    }

    var itemInfo: some View {
        VStack {
            Spacer()
                .frame(height: 50)
           Image(productImageUrl)
                .resizable()
                .scaledToFit()
                .frame(width: 87, height: 78)
                .padding(.bottom, 10)
            Text("\(productPrice, specifier: "%3.f")만원까지")
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(.basicBlack.opacity(0.6))
                .opacity(0.6)
            Text("\(progressPercent, specifier: "%3.f")%")
                .font(.system(size: 60, weight: .bold))
                .foregroundColor(.pointColor)
            Spacer()
                .frame(height: 14)
            Text("저축 완료일")
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(.basicBlack.opacity(0.4))
            Text("\(dateFormatter(date: lastDate))")
                .font(.system(size: 16, weight: .bold))
                .foregroundColor(.basicBlack)
        }
    }
    
    var weekInfo: some View {
        HStack {
            if totalFailedNum != 0 {
                HStack {
                    Text("\(goalWeeks)+")
                    Text("\(totalFailedNum)주")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(Color.alertRed)
                        .offset(x: -5)
                }
            } else {
                Text("\(goalWeeks)주")
            }
        }
        .font(.system(size: 16, weight: .medium))
    }
}

struct MyProgressCircle_Previews: PreviewProvider {
    static var previews: some View {
        MyProgressCircle(user: dummyMy)
    }
}
