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
            FriendAdditionView(onboardingViewModel: OnBoardingViewModel())
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
    
    var body: some View {
        VStack {
            TitleView()
                .padding(EdgeInsets(top: 20, leading: 0, bottom: 0, trailing: 0))
            ApplyFriendIdTextView()
                .padding(EdgeInsets(top: 40, leading: 21, bottom: 0, trailing: 0))
            PinStackView(attempts: $attemps, pin: $text, wrongFriendInput: $noFriendId, isKeyboardHide: $isKeyboardHide, handler: { result, status in
                if status {

                    FirebaseManager.shared.isFriendUidExist(friendUid: result) { nickName in
                        if let nickName = nickName {
                            if (addedFriendDic[result] == nil) {
                                addedFriendDic.updateValue(nickName, forKey: result)
                                addedFriendList.append(nickName)
                            }
                        }
                         else {
                        noFriendId = true
                         }
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        text = ""
                    }
                }
                
//                if status {
//                    if let friend = isPinExistValue(inputString: result) {
//
//                        if (addedFriendDic[text] == nil) {
//                            addedFriendDic.updateValue(friend, forKey: text)
//                            addedFriendList.append(friend)
//                        }
//                    } else {
//                        noFriendId = true
//                    }
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
//                        text = ""
//                    }
//                }
                
            })
            .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 0))
            NoFriendTextView(isFriendWrong: $noFriendId)
            if addedFriendDic.isEmpty {
                HStack {
                    LaterAddButtonView()
                    Spacer()
                }.padding(EdgeInsets(top: 31, leading: 20, bottom: 0, trailing: 0))
            } else {
                AlreadyAddedFriendView(addedFriendDic: $addedFriendDic, addedFriendList: $addedFriendList)
            }
            Spacer()
            NavigationLink(destination: LastOnboardingView(onboardingViewModel: onboardingViewModel).onAppear(perform: {
                userViewModel.getFriendUid(friendUids: Array(addedFriendDic.keys))
                if !addedFriendDic.isEmpty {
                    FirebaseManager.shared.fetchFriendNickname(friendUids: Array(addedFriendDic.keys))
                    userViewModel.nicknameUpgrade(str: Array(addedFriendDic.values))
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
            .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
        }
        .ignoresSafeArea(.keyboard)
            
    }

}

func isPinExistValue(inputString: String) -> String?{
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
        FriendAdditionView(onboardingViewModel: OnBoardingViewModel())
            .previewInterfaceOrientation(.portrait)
    }
}


////
////  AddingFriend.swift
////  ToGather
////
////  Created by yudonlee on 2022/06/08.
////
//
//import SwiftUI
//
//struct FriendNavigationViewTest: View {
//    var body: some View {
//        NavigationView {
//            FriendAdditionView(onboardingViewModel: OnBoardingViewModel())
//                .toolbar {
//                    ToolbarItem(placement: .navigationBarLeading) {
//                        Button {
//                            print("Edit button was tapped")
//                        } label: {
//                            Image(systemName: "arrow.backward")
//                        }
//
//                        }
//                }
//                .navigationBarTitleDisplayMode(.inline)
//        }
//    }
//}
//
//struct NoFriendTextView: View {
//    @Binding var isFriendWrong: Bool
//    var body: some View {
//        Text("없는 ID에요")
//            .foregroundColor(isFriendWrong ? .red: .white)
//            .font(.system(size: 14, weight: .bold))
//            .frame(minWidth: 0, idealWidth: .infinity, maxWidth: .infinity, minHeight: 0, idealHeight: 17, maxHeight: 17, alignment: .topLeading)
//            .padding(EdgeInsets(top: 12, leading: 20, bottom: 0, trailing: 0))
//    }
//}
//
///// 친구추가 페이지 뷰
//struct FriendAdditionView: View {
//    @State var text = ""
//    @State var noFriendId: Bool = false
//    @State var attemps: Int = 0
//    @State var addedFriendList: [String] = []
//    @State var addedFriendDic: [String: String] = [:]
//    @StateObject var onboardingViewModel: OnBoardingViewModel
//    @FocusState var isKeyboardHide: Bool
//
//    var body: some View {
//        VStack {
//            TitleView()
//                .padding(EdgeInsets(top: 20, leading: 0, bottom: 0, trailing: 0))
//            ApplyFriendIdTextView()
//                .padding(EdgeInsets(top: 40, leading: 21, bottom: 0, trailing: 0))
//            PinStackView(attempts: $attemps, pin: $text, wrongFriendInput: $noFriendId, isKeyboardHide: $isKeyboardHide, handler: { result, status in
//                if status {
//                    if let friend = isPinExistValue(inputString: result) {
//                        if let val = addedFriendDic[text] {
//                            addedFriendDic.updateValue(text, forKey: friend)
//                        }
//
//                    } else {
//                        noFriendId = true
//                    }
////                    if friend = isPinExistValue(inputString: result) {
////                        if addedFriendList[friend] {
////                            addedFriendList.append(friend)
////                        }
////
////                    } else {
////                        noFriendId = true
////                    }
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
//                        text = ""
//                    }
//                }
//            })
//            .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 0))
//            NoFriendTextView(isFriendWrong: $noFriendId)
//            if addedFriendList.isEmpty {
//                HStack {
//                    LaterAddButtonView()
//                    Spacer()
//                }.padding(EdgeInsets(top: 31, leading: 20, bottom: 0, trailing: 0))
//            } else {
//                AlreadyAddedFriendView(addedFriendList: $addedFriendList)
//            }
//            Spacer()
//            NavigationLink(destination: LastOnboardingView(onboardingViewModel: onboardingViewModel), label: {
//                Text("다음")
//                    .fontWeight(.bold)
//                    .frame(width: UIScreen.main.bounds.width - 40, height: 46)
//                    .foregroundColor(.white)
//                    .background(Color.pointColor)
//                    .cornerRadius(30)
//                    .padding(.horizontal, 20)
//            })
//            .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
//        }
//        .ignoresSafeArea(.keyboard)
//
//    }
//
//}
//
//func isPinExistValue(inputString: String) -> String?{
//    guard let value = testPin[inputString] else {
//        return nil
//    }
//    return value
//}
//
//func isPinExist(inputString: String) -> Bool {
//    guard let value = testPin[inputString] else {
//        return false
//    }
//    return true
//}
//extension FriendAdditionView {
//}
//
//struct AddingFriend_Previews: PreviewProvider {
//    static var previews: some View {
//        FriendAdditionView(onboardingViewModel: OnBoardingViewModel())
//            .previewInterfaceOrientation(.portrait)
//    }
//}
