//
//  AddingFriendCircle.swift
//  ToGather
//
//  Created by Seungwon Choi on 2022/07/20.
//

import SwiftUI

struct AddingFriendProgressCircle: View, Identifiable {
    let id: Int
    let user: User
    var color: RGBColorInProgressCircle

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
                ProgressCircle(color: color, frameSize: 130, saving: saving)
            }
        }
       // .frame(height: 123)
    }
}

extension AddingFriendProgressCircle {
    var itemInfo: some View {
        VStack {
            Image(friendProduct)
                .resizable()
                .scaledToFit()
                .frame(width: 71, height: 71)
                .padding(.top)
            Text("\(progressPercent, specifier: "%3.f")%")
                .font(.system(size: 16, weight: .bold))
                .foregroundColor(color.start)
        }
    }
}

struct AddingFriendProgressCircle_Previews: PreviewProvider {
    static var previews: some View {
        HStack {
            AddingFriendProgressCircle(id: 1, user: dummyFriend1, color: RGBColorInProgressCircle.myColor)
        }
    }
}
