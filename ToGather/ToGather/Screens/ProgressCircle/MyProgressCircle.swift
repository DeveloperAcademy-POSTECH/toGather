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

    var body: some View {
        ZStack {
            ProgressCircle(color: RGBColorInProgressCircle.myColor, frameSize: 330, saving: saving)
            itemInfo
        }
    }
}

extension MyProgressCircle {
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
            Text("2022.09.03")
                .font(.system(size: 16, weight: .bold))
                .foregroundColor(.basicBlack)
        }
    }
}

struct MyProgressCircle_Previews: PreviewProvider {
    static var previews: some View {
        MyProgressCircle(user: dummyMy)
    }
}
