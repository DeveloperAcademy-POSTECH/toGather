//
//  FriendsProgressCircle.swift
//  ToGather
//
//  Created by hyo on 2022/06/12.
//

import SwiftUI

struct FriendProgressCircle: View, Identifiable {
    let id: Int
    let user: User
    var color: Color

    var saving: Saving {user.saveInfo}
    var productImageUrl: String {Product.productDictionary[user.saveInfo.goalProduct]?.imageUrl ?? ""}
    var productPrice: Double {Product.productDictionary[user.saveInfo.goalProduct]?.productPrice ?? 0}
    var progressPercent: Double {user.saveInfo.progressPercent}
    var friendProduct: String {user.saveInfo.goalProduct}
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

extension FriendProgressCircle {
    var itemInfo: some View {
        VStack {
            Image(friendProduct)
                .resizable()
                .scaledToFit()
                .frame(width: 53, height: 53)
                .padding(.top)
            Text("\(progressPercent, specifier: "%3.f")%")
                .font(.system(size: 14, weight: .bold))
                .foregroundColor(color)
        }
    }
}

struct FriendsProgressCircle_Previews: PreviewProvider {
    static var previews: some View {
        HStack {
            FriendProgressCircle(id: 1, user: DummyData.friend1, color: .friendRed01)
        }
    }
}
