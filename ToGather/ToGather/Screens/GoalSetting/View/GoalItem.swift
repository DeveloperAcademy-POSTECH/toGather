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
    @Binding var isSelectedItem: String?
    init(imageTitle: String,
         price: String,
         isSelectedItem: Binding<String?> = .constant("")) {
        self.imageTitle = imageTitle
        self.price = price
        _isSelectedItem = isSelectedItem
    }
    var body: some View {
        VStack(spacing: 4) {
            Image(imageTitle)
                .frame(width: 100, height: 100, alignment: .center)
                .clipShape(Circle())
                .overlay {
                    Circle()
                        .stroke(lineWidth: isSelectedItem == imageTitle ? 1 : 0)
                        .foregroundColor(Color.pointColor)
                }
            Text(price)
                .fontWeight(.medium)
                .foregroundColor(isSelectedItem == imageTitle ? Color.pointColor : Color.black)
        } // VStack
        .onTapGesture {
            guard let isSelectedItem = isSelectedItem else {
                self.isSelectedItem = imageTitle
                return
            }
            if isSelectedItem == imageTitle {
                self.isSelectedItem = nil
            } else {
                self.isSelectedItem = imageTitle
            }
        }
    }
}

struct GoalItem_Previews: PreviewProvider {
    static var previews: some View {
//        GoalItem(imageTitle: "goal-ipad", price: "700,000", isSelected: true)
        GoalItem(imageTitle: "goal-ipad", price: "700,000", isSelectedItem: .constant(""))
    }
}
