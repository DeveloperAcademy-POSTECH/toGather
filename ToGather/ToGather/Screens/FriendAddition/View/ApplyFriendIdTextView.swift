//
//  FriendIdView.swift
//  ToGather
//
//  Created by yudonlee on 2022/06/08.
//

import SwiftUI

struct ApplyFriendIdTitle: View {
    var body: some View {
        Text("친구 ID를 적어주세요")
            .font(.system(size: 20))
            .fontWeight(.bold)
            .frame(minWidth: 0, idealWidth: .infinity, maxWidth: .infinity,
                   minHeight: 0, idealHeight: 24,
                   maxHeight: 24, alignment: .topLeading)
    }
}

struct ApplyFriendIdTextView: View {
    var body: some View {
        ApplyFriendIdTitle()
    }
}

struct FriendIdView_Previews: PreviewProvider {
    static var previews: some View {
        ApplyFriendIdTextView()
    }
}
