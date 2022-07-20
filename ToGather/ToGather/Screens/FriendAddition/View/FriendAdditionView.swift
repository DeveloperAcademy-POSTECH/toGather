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
            FriendAdditionView(onboardingViewModel: OnBoardingViewModel(), isPresentationMode: .constant(true))
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

/// 친구추가 페이지 뷰
struct FriendAdditionView: View {
    @State var text = ""
    @State var noFriendId: Bool = false
    @State var attemps: Int = 0
    @State var addedFriendList: [String] = []
    @State var addedFriendDic: [String: String] = [:]
    @StateObject var onboardingViewModel: OnBoardingViewModel
    @EnvironmentObject var userViewModel: UserViewModel
    @FocusState var isKeyboardHide: Bool
    
    @Binding var isPresentationMode: Bool

    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @StateObject var friendAdditionViewModel =  FriendAdditionViewModel()

    var body: some View {
        VStack {
            TitleView()
                .padding(EdgeInsets(top: 20, leading: 0, bottom: 0, trailing: 0))
            ApplyFriendIdTextView()
                .padding(EdgeInsets(top: 40, leading: 21, bottom: 0, trailing: 0))
            PinStackView(attempts: $attemps, pin: $text, wrongFriendInput: $noFriendId, isKeyboardHide: $isKeyboardHide, handler: { result, status in
                if status {

                    if friendAdditionViewModel.insertFriendUids(uid: result) {
                        noFriendId = true
                    }
                    text = ""
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
//                        text = ""
//                    }
                }
            })
            .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 0))
            NoFriendTextView(isFriendWrong: $noFriendId)
        
            if friendAdditionViewModel.isFriendEmpty() {
                HStack {
                    NavigationLink(destination: LastOnboardingView(onboardingViewModel: onboardingViewModel, isPresentationMode: $isPresentationMode), label: {
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
            Spacer()
            if onboardingViewModel.isFirstOn {
                NavigationLink(destination: LastOnboardingView(onboardingViewModel: onboardingViewModel, isPresentationMode: $isPresentationMode).onAppear(perform: {
                    
                    if let friendNicknames = friendAdditionViewModel.getFriendNickname(), let friendUids = friendAdditionViewModel.getFriendUids() {
                        userViewModel.setFriendUid(friendUids: friendUids)
                        userViewModel.setFriendNickname(friendNicknames: friendNicknames)
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
        .ignoresSafeArea(.keyboard)
            
    }

}

func isPinExistValue(inputString: String) -> String? {
    guard let value = testPin[inputString] else {
        return nil
    }
    return value
}

func isPinExist(inputString: String) -> Bool {
    guard let value = testPin[inputString] else {
        return false
    }
    return true
}
extension FriendAdditionView {
}

struct AddingFriend_Previews: PreviewProvider {
    static var previews: some View {
        FriendAdditionView(onboardingViewModel: OnBoardingViewModel(), isPresentationMode: .constant(true))
            .previewInterfaceOrientation(.portrait)
    }
}
