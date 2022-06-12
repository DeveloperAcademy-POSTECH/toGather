//
//  GoalItem.swift
//  ToGather
//
//  Created by yeongwoocho on 2022/06/09.
//

import SwiftUI

struct GoalItem: View {
    @State var isSelected: Bool
    var imageTitle: String?
    var price: String?
    var body: some View {
        VStack(spacing: 4) {
            if let imageTitle = imageTitle {
                Image(imageTitle)
                    .frame(width: 100, height: 100, alignment: .center)
                    .clipShape(Circle())
                    .overlay {
                        Circle()
                            .stroke(lineWidth: isSelected ? 1 : 0)
                            .foregroundColor(.blue)
                    }
            } else {
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(width: 100, height: 100, alignment: .center)
            }
            Text(price ?? "")
                .fontWeight(.medium)
                .foregroundColor(isSelected ? Color.blue : Color.black)
        } // VStack
        .onTapGesture {
            isSelected.toggle()
        }
    }
}

struct GoalItem_Previews: PreviewProvider {
    static var previews: some View {
        GoalItem(isSelected: true, imageTitle: "goal-ipad", price: "700,000")
    }
}
