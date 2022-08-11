//
//  PersonView.swift
//  ToGather
//
//  Created by DaeSeong on 2022/08/11.
//

import SwiftUI

struct PersonView: View {
    // MARK: - Properties
    @StateObject var friendAdditionViewModel: FriendAdditionViewModel
    @Binding var nickname: String
    
    // MARK: - Body
    var body: some View {
        VStack {
            ZStack {
                ZStack(alignment: .topTrailing) {
                    Circle()
                        .strokeBorder(lineWidth: 1)
                        .foregroundColor(ColorStyle.blue.color)
                        .frame(width: 80, height: 80, alignment: .center)
                    ZStack(alignment: .topTrailing) {
                        Button {
                            friendAdditionViewModel.removeFriendNickname(nickname: nickname)
                        } label: {
                            Image(systemName: "minus.circle.fill")
                                .foregroundColor(.red)
                                .font(.system(size: 16))
                        }
                    }.padding(EdgeInsets(top: 1, leading: 0, bottom: 0, trailing: 1))
                    
                }
                Image(systemName: "person.fill")
                    .font(.system(size: 40))
                    .foregroundColor(.blue)
                
            }
            Text("\(nickname)")
                .font(.system(size: 14))
                .fontWeight(.bold)
                .foregroundColor(.basicBlack)
        }
    }
}
