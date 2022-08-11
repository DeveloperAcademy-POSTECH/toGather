//
//  AlreadyAddedFriendView.swift
//  ToGather
//
//  Created by yudonlee on 2022/06/10.
//

import SwiftUI

struct AlreadyAddedFriendView: View {
    // MARK: - Properties
    @StateObject var friendAdditionViewModel: FriendAdditionViewModel
    
    // MARK: - Body
    var body: some View {
        FriendSavingWithMe
            .padding(EdgeInsets(top: 11, leading: 21, bottom: 0, trailing: 0))
        
        HStack(spacing: 36) {
            if let friendNicknames = friendAdditionViewModel.getFriendNicknames() {
                ForEach(friendNicknames, id: \.self) { item in
                    PersonView(friendAdditionViewModel: friendAdditionViewModel, nickname: .constant(item))
                }
            }
            Spacer()
        }    .padding(EdgeInsets(top: 12, leading: 20, bottom: 0, trailing: 0))
    }

}
// MARK: - Extensions

extension AlreadyAddedFriendView {
    var FriendSavingWithMe : some View {
        Text("같이 저축할 친구")
            .font(.system(size: 20))
            .frame(minWidth: 0, idealWidth: .infinity, maxWidth: .infinity,
                   minHeight: 0, idealHeight: 24,
                   maxHeight: 24, alignment: .topLeading)
    }
}



