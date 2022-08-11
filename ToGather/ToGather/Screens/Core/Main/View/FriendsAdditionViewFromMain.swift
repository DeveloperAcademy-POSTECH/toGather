//
//  FriendsAdditionFromMainView.swift
//  ToGather
//
//  Created by hyo on 2022/08/11.
//
import SwiftUI

/// 친구추가 페이지 뷰
struct FriendAdditionViewFromMain: View {
    @State var text = ""
    @State var noFriendId: Bool = false
    @State var attemps: Int = 0
    
    @EnvironmentObject var userViewModel: UserViewModel
    @FocusState var isKeyboardHide: Bool
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @StateObject var friendAdditionViewModel =  FriendAdditionViewModel()

    var body: some View {
        VStack {
            TitleView()
                .padding(EdgeInsets(top: 20, leading: 0, bottom: 0, trailing: 0))
            ApplyFriendIdTextView()
                .padding(EdgeInsets(top: 40, leading: 21, bottom: 0, trailing: 0))
            PinStackView(attempts: $attemps, pin: $text, wrongFriendInput: $noFriendId, isKeyboardHide: $isKeyboardHide, handler: { result, status in
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    if status {
                        friendAdditionViewModel.insertFriendUids(uid: result) { isFriendIdExist in
                            if !isFriendIdExist {
                                noFriendId = true
                            }
                            text = ""
                        }
                    }
                }
            })
            .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 0))
            isFriendIdInvalid
            isFriendAlreadyExistOrNot
            Spacer()
            completeButton
        }
        .ignoresSafeArea(.keyboard)
    }
    
    private var isFriendIdInvalid: some View {
        return VStack {
            Text("없는 ID에요")
                .foregroundColor(noFriendId ? .red: .white)
                .font(.system(size: 14, weight: .bold))
                .frame(minWidth: 0, idealWidth: .infinity, maxWidth: .infinity, minHeight: 0, idealHeight: 17, maxHeight: 17, alignment: .topLeading)
                .padding(EdgeInsets(top: 12, leading: 20, bottom: 0, trailing: 0))
        }
    }
    
    private var isFriendAlreadyExistOrNot: some View {
        return VStack {
            if !friendAdditionViewModel.isFriendEmpty() {
                AlreadyAddedFriendView(friendAdditionViewModel: friendAdditionViewModel)
            }
        }
    }
    
    private var completeButton: some View {
        return VStack {
            Button {
                if let friendNicknames = friendAdditionViewModel.getFriendNicknames(), let friendUids = friendAdditionViewModel.getFriendUids() {
                    userViewModel.appendFriendUids(friendUids: friendUids)
                    userViewModel.appendFriendNicknames(friendNicknames: friendNicknames)
                    userViewModel.uploadFriendsData()
                    userViewModel.requestFriendProgressCircles()
                }
                presentationMode.wrappedValue.dismiss()
            } label: {
                Text("완료")
                    .fontWeight(.bold)
                    .frame(width: UIScreen.main.bounds.width - 40, height: 46)
                    .foregroundColor(.white)
                    .background(Color.pointColor)
                    .cornerRadius(30)
                    .padding(.horizontal, 20)
            }
        }
    }
}

struct AddingFriendFromMain_Previews: PreviewProvider {
    static var previews: some View {
        FriendAdditionViewFromMain()
            .previewInterfaceOrientation(.portrait)
    }
}
