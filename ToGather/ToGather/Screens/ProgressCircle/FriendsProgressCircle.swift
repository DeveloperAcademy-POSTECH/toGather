//
//  FriendsProgressCircle.swift
//  ToGather
//
//  Created by hyo on 2022/06/12.
//

import SwiftUI

struct FriendsProgressCircle: View, Identifiable {
    let id: Int
    let user: User
    var color: RGBColorInProgressCircle

    var saving: Saving {user.saveInfo}
    var productImageUrl: String {user.saveInfo.goalProduct.imageUrl}
    var productPrice: Double {user.saveInfo.goalProduct.productPrice}
    var progressPercent: Double {user.saveInfo.progressPercent}
    var friendProduct: Product {user.saveInfo.goalProduct}
    var friendName: String {user.nickname}

    var body: some View {
        VStack(spacing: 6) {
            ZStack {
                itemInfo
                ProgressCircle(color: color, frameSize: 100, saving: saving)
            }
            Text(friendName)
                    .font(.system(size: 14))
        }
       // .frame(height: 123)
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
            FriendsProgressCircle(id: 1, user: dummyFriend1, color: RGBColorInProgressCircle.friendColor1)
        }
    }
}
