//
//  myProgressCircle.swift
//  ToGather
//
//  Created by hyo on 2022/06/12.
//

import SwiftUI

let myColor = RGBColorInProgressCircle(red: 0.44, green: 0.66, blue: 0.97)

struct MyProgressCircle: View {
    var body: some View {
        ZStack {
            ProgressCircle(color: myColor, frameSize: 330)
            itemInfo
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

        Text("\(progressPercent, specifier: "%3.f")%")
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

struct MyProgressCircle_Previews: PreviewProvider {
    static var previews: some View {
        MyProgressCircle()
    }
}
