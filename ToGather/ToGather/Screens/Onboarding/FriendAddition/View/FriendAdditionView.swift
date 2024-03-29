//
//  AddingFriend.swift
//  ToGather
//
//  Created by yudonlee on 2022/06/08.
//

import SwiftUI


/// 친구추가 페이지 뷰
struct FriendAdditionView: View {
    // MARK: - Properties
    @State var text = ""
    @State var noFriendId: Bool = false
    @State var attemps: Int = 0
    
    @EnvironmentObject var userViewModel: UserViewModel

    @FocusState var isKeyboardHide: Bool
    @Binding var isPresentationMode: Bool
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @StateObject var friendAdditionViewModel =  FriendAdditionViewModel()

    @AppStorage("isVisited") var isFirstOn = !UserDefaults.standard.bool(forKey: "isVisited")


    // MARK: - Body
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
    

}

// MARK: - Extensions
extension FriendAdditionView {
    
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
            if friendAdditionViewModel.isFriendEmpty() {
                HStack {
                    CustomNavigationLink(destination: LastOnboardingView( isPresentationMode: $isPresentationMode), label: {
                        ZStack {
                            Text("나중에 추가하기")
                                .font(.system(size: 16))
                                .frame(width: 102, height: 19)
                                .foregroundColor(.basicBlack.opacity(0.6))
                            RoundedRectangle(cornerRadius: 10)
                                .frame(width: 122, height: 39)
                                .foregroundColor(.basicBlack.opacity(0.05))
                            
                        }
                    })
                    Spacer()
                }.padding(EdgeInsets(top: 31, leading: 20, bottom: 0, trailing: 0))
            } else {
                AlreadyAddedFriendView(friendAdditionViewModel: friendAdditionViewModel)
            }
        }
    }
    
    private var completeButton: some View {
        return VStack {
            if isFirstOn {
                CustomNavigationLink(destination: LastOnboardingView( isPresentationMode: $isPresentationMode).onAppear(perform: {
                    if let friendNicknames = friendAdditionViewModel.getFriendNicknames(), let friendUids = friendAdditionViewModel.getFriendUids() {
                        userViewModel.setFriendUids(friendUids: friendUids)
                        userViewModel.setFriendNicknames(friendNicknames: friendNicknames)
                    }
                }), label: {
                    Text("다음")
                        .fontWeight(.bold)
                        .frame(width: UIScreen.main.bounds.width - 40, height: 46)
                        .foregroundColor(.white)
                        .background(Color.pointColor)
                        .cornerRadius(30)
                        .padding(.horizontal, 20)
                })
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
            } else {
                Button {
                    // 친구 추가 코드 필요.
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
}
// MARK: - Previews
struct AddingFriend_Previews: PreviewProvider {
    static var previews: some View {
        FriendAdditionView(isPresentationMode: .constant(true))
            .previewInterfaceOrientation(.portrait)
    }
}
