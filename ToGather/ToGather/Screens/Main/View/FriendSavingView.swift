//
//  FriendSavingView.swift
//  ToGather
//
//  Created by DaeSeong on 2022/06/09.
//

import SwiftUI

struct FriendSavingView: View {
    let image: String
    let percentage: Double
    var colors: [Color]
    let backgroundColor: Color
    let unfillColor: Color
    let friendName: String

    var body: some View {
        VStack {
        ZStack {
            VStack {
            Image(image)
                .resizable()
                .scaledToFit()
                .frame(width: 53, height: 53)
                Text("\(Int(percentage*100))%")
                    .font(.caption)
            }
        CircleProgress(percentage: percentage,
                       radius: 100,
                       gradientColors: colors,
                       backgroundColor: backgroundColor,
                       unfillColor: unfillColor)
        }
        Text(friendName)
                .font(.system(size: 14))
    }
    }
}

struct FriendSavingView_Previews: PreviewProvider {
    static var previews: some View {
        FriendSavingView(image: "Ipad",
                         percentage: 0.56,
                         colors: [
            Color(red: 0.779, green: 0.097, blue: 0.248, opacity: 1),
              Color(red: 0.918, green: 0.298, blue: 0.435, opacity: 1)
                  ],
                         backgroundColor: Color.basicRed.opacity(0.05),
                         unfillColor: Color.basicRed.opacity(0.2),
                         friendName: "Tim")
    }
}
