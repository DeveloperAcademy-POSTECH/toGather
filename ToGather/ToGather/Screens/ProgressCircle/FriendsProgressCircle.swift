//
//  FriendsProgressCircle.swift
//  ToGather
//
//  Created by hyo on 2022/06/12.
//

import SwiftUI

struct FriendsProgressCircle: View {
    var color: RGBColorInProgressCircle
    let progressPercent: Double
    let friendName: String
    var friendProduct: Product
    var body: some View {
        VStack(spacing: 6) {
            ZStack {
                itemInfo
                ProgressCircle(color: color, frameSize: 100)
            }
            Text(friendName)
                    .font(.system(size: 14))
        }
    }
}

extension FriendsProgressCircle {
    var itemInfo: some View {
        VStack {
            Image(friendProduct.productName)
                .resizable()
                .scaledToFit()
                .frame(width: 53, height: 53)
                .padding(.top)
            Text("\(progressPercent, specifier: "%3.f")%")
                .font(.system(size: 14, weight: .bold))
                .foregroundColor(color.start)
        }
    }
}

struct FriendsProgressCircle_Previews: PreviewProvider {
    static var previews: some View {
        HStack {
            FriendsProgressCircle(color: RGBColorInProgressCircle.friendColor1,
                                  progressPercent: 30,
                                  friendName: "Tim",
                                  friendProduct: Product.sampleData[1])
        }
    }
}
