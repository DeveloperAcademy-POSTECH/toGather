//
//  AddingFriend.swift
//  ToGather
//
//  Created by yudonlee on 2022/06/08.
//

import SwiftUI

struct FriendNavigationViewTest: View {
    var body: some View {
        NavigationView {
            
            FriendAdditionView()
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button {
                            print("Edit button was tapped")
                        } label: {
                            Image(systemName: "arrow.backward")
                        }

                        }
                }
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct NoFriendTextView: View {
    @Binding var isFriendWrong: Bool
    var body: some View {
        Text("없는 ID에요")
            .foregroundColor(isFriendWrong ? .red: .white)
            .font(.system(size: 14, weight: .bold))
            .frame(minWidth: 0, idealWidth: .infinity, maxWidth: .infinity, minHeight: 0, idealHeight: 17, maxHeight: 17, alignment: .topLeading)
            .padding(EdgeInsets(top: 12, leading: 20, bottom: 0, trailing: 0))
    }
}


struct FriendAdditionView: View {
    @State var text = ""
    @State var noFriendId: Bool = false
    @State var attemps: Int = 0
    @State var addedFriendList: [String] = []
    
    var body: some View {
        VStack {
            TitleView()
                .padding(EdgeInsets(top: 20, leading: 0, bottom: 0, trailing: 0))
            ApplyFriendIdTextView()
                .padding(EdgeInsets(top: 40, leading: 21, bottom: 0, trailing: 0))
            PinStackView(attempts: $attemps, pin: $text, wrongFriendInput: $noFriendId, handler: {
                result, status in
                if status {
                    if isPinExist(inputString: result) {
                        pinFriendAdd()
                    } else {
                        noFriendId = true
                    }
                    text = ""
                }
            })
            .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 0))
            NoFriendTextView(isFriendWrong: $noFriendId)
            
            if addedFriendList.isEmpty {
                HStack {
                    LaterAddButtonView()
                    Spacer()
                }.padding(EdgeInsets(top: 31, leading: 20, bottom: 0, trailing: 0))
            }
            else {
                AlreadyAddedFriendView(addedFriendList: $addedFriendList)
            }
            Spacer()
        }
    }

}

extension FriendAdditionView {
    func isPinExist(inputString: String) -> Bool{
        guard let value = testPin[inputString] else {
            return false
        }
        addedFriendList.append(value)
        return true
    }
}

struct AddingFriend_Previews: PreviewProvider {
    static var previews: some View {
        FriendAdditionView()
            .previewInterfaceOrientation(.portrait)
    }
}
