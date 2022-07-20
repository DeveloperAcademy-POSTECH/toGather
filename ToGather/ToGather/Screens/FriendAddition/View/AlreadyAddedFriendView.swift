//
//  AlreadyAddedFriendView.swift
//  ToGather
//
//  Created by yudonlee on 2022/06/10.
//

import SwiftUI

struct FriendSavingWithMe: View {
    var body: some View {
        Text("같이 저축할 친구")
            .font(.system(size: 20))
            .frame(minWidth: 0, idealWidth: .infinity, maxWidth: .infinity,
                   minHeight: 0, idealHeight: 24,
                   maxHeight: 24, alignment: .topLeading)
    }
}


struct AlreadyAddedFriendView: View {
    @StateObject var friendAdditionViewModel: FriendAdditionViewModel
    
    var body: some View {
        FriendSavingWithMe()
            .padding(EdgeInsets(top: 11, leading: 21, bottom: 0, trailing: 0))
        HStack(spacing: 36) {
            if let friendNicknames = friendAdditionViewModel.getFriendNickname() {
                ForEach(friendNicknames, id: \.self) { item in
                    PersonView(friendAdditionViewModel: friendAdditionViewModel, nickname: .constant(item))
                }
            }
            Spacer()
        }    .padding(EdgeInsets(top: 12, leading: 20, bottom: 0, trailing: 0))
    }

}
struct PersonView: View {
    @StateObject var friendAdditionViewModel: FriendAdditionViewModel
    @Binding var nickname: String
    
    var body: some View {
        VStack {
            ZStack {
                ZStack(alignment: .topTrailing) {
                    Circle()
                        .strokeBorder(lineWidth: 1)
                        .foregroundColor(ColorStyle.blue.color)
                        .frame(width: 80, height: 80, alignment: .center)
//                    Badge(nickname: $nickname)
                    ZStack(alignment: .topTrailing) {
                        Button {
                            friendAdditionViewModel.removeFriendNickname(nickname: nickname)
                        } label: {
                            Image(systemName: "minus.circle.fill")
                                .foregroundColor(.red)
                            //                    .background()
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
