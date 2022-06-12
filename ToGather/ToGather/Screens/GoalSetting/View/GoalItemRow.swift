//
//  GoalItemRow.swift
//  ToGather
//
//  Created by yeongwoocho on 2022/06/09.
//

import SwiftUI

struct GoalItemRow: View {
    var headline: String
    var firstImageTitle: String
    var firstPrice: String
    var secondImageTitle: String
    var secondPrice: String
    var thirdImageTitle: String?
    var thirdPrice: String?
    var body: some View {
        VStack(spacing: 0) {
            HStack(alignment: .bottom, spacing: 4) {
                Text(headline)
                    .font(.system(size: 20))
                    .fontWeight(.heavy)
                    .foregroundColor(Color.pointColor)
                    .padding(.leading, 20)
                Text("미만")
                    .foregroundColor(Color.basicBlack)
                    .padding(.bottom, 2) // for same border line
                Spacer()
            } // HStack
            .padding(.bottom, 6)
            Divider()
                .padding(.horizontal, 20)
                .padding(.bottom, 8)
            HStack(alignment: .center, spacing: 0) {
                GoalItem(isSelected: false, imageTitle: firstImageTitle, price: firstPrice)
                Spacer()
                GoalItem(isSelected: false, imageTitle: secondImageTitle, price: secondPrice)
                Spacer()
                GoalItem(isSelected: false, imageTitle: thirdImageTitle ?? nil, price: thirdPrice ?? nil)
            } // HStack
            .padding(.horizontal, 20)
        } // VStack
        .padding(.vertical, 22)
    }
}

struct GoalItemRow_Previews: PreviewProvider {
    static var previews: some View {
        GoalItemRow(headline: "100만원",
                    firstImageTitle: "goal-airpod",
                    firstPrice: "300,000",
                    secondImageTitle: "goal-applewatch",
                    secondPrice: "500,000",
                    thirdImageTitle: nil,
                    thirdPrice: nil)
    }
}
