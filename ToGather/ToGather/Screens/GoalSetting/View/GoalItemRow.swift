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
    var thirdImageTitle: String
    var thirdPrice: String
    var body: some View {
        VStack(spacing: 0) {
            HStack(alignment: .bottom, spacing: 4) {
                Text(headline)
                    .font(.system(size: 20))
                    .fontWeight(.heavy)
                    .foregroundColor(Color.blue)
                    .padding(.leading, 20)
                Text("미만")
                    .foregroundColor(ColorStyle.blackHundred.color)
                Spacer()
            } // HStack
            .padding(.bottom, 6)
            Divider()
                .padding(.horizontal, 20)
            HStack(alignment: .center, spacing: 0) {
                GoalItem(imageTitle: firstImageTitle, price: firstPrice)
                Spacer()
                GoalItem(imageTitle: secondImageTitle, price: secondPrice)
                Spacer()
                GoalItem(imageTitle: thirdImageTitle, price: thirdPrice)
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
                    thirdImageTitle: "goal-ipad",
                    thirdPrice: "700,000")
    }
}
