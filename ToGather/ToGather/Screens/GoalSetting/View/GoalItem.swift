//
//  GoalItem.swift
//  ToGather
//
//  Created by yeongwoocho on 2022/06/09.
//

import SwiftUI

struct GoalItem: View {
    var imageTitle: String
    var price: String
    var body: some View {
        VStack(spacing: 4) {
            Image(imageTitle)
                .frame(width: 100, height: 100, alignment: .center)
            Text(price)
                .fontWeight(.medium)
        } // VStack
    }
}

struct GoalItem_Previews: PreviewProvider {
    static var previews: some View {
        GoalItem(imageTitle: "goal-ipad", price: "700,000")
    }
}
