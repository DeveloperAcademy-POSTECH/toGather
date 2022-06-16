//
//  MainView.swift
//  ToGather
//
//  Created by DaeSeong on 2022/06/09.
//

import SwiftUI

struct MainView: View {
    @State var friendsCount  = 0
    @StateObject var viewModel = MainViewModel()
    var body: some View {
        NavigationView {
            VStack {
                friendsSavingsView
                    .padding()
                Divider()
                    .padding(.horizontal)
                    .padding(.bottom, 25)
                mySavingsView
                Spacer(minLength: 68)
                bottomView
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarLeading) {
                    Text("친구 저축현황")
                        .font(.system(size: 22, weight: .bold))
                }
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    toolbarButtonsView
                }
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

extension MainView {
    
    var toolbarButtonsView: some View {
        HStack {
            NavigationLink {
                NotificationsView()
                    .navigationTitle("알림")
                    .navigationBarHidden(true)
            } label: {
                Image(systemName: "bell.badge.fill")
                    .symbolRenderingMode(.palette)
                    .foregroundStyle( .red, Color.basicBlack.opacity(0.4))
            }
            .foregroundColor(.basicBlack.opacity(0.4))
            Button {
                //
            } label: {
                Image(systemName: "gear")
            }
            .foregroundColor(.basicBlack.opacity(0.4))
        }
    }
    
    var friendsSavingsView: some View {
        HStack(spacing: 26) {
            ForEach(viewModel.getFriendList()) { friendSaving in
                friendSaving
            }
            // MARK: - 추후 코드변경이 필요.
            if viewModel.getFriendList().isEmpty {
                VStack(spacing: 4) { // 하드코딩 수정필요
                    Button {
                        viewModel.addFriend(friend:
                            FriendsProgressCircle(id: 1, user: dummyFriend1, color: RGBColorInProgressCircle.friendColor1)
                        )
                    } label: {
                        AddedCircleView(color: .friendRed01)
                    }
                    Text("친구랑 같이 저축하기")
                        .font(.callout) // 16px
                        .fontWeight(.semibold)
                }
            } else if viewModel.getFriendList().count == 1 {
                VStack(spacing: 4) {
                    Button {
                        // TODO: - 인자에 toUid 업데이트 예정
                        FirebaseManager.shared.uploadNotification(type: .mySavingDay)
                         viewModel.addFriend(friend:
                            FriendsProgressCircle(id: 2, user: dummyFriend2, color: RGBColorInProgressCircle.friendColor2)
                        )
                    } label: {
                        AddedCircleView(color: .friendPurple01)
                    }
                    Text("친구 추가")
                        .font(.callout) // 16px
                        .fontWeight(.semibold)
                }
            } else if viewModel.getFriendList().count == 2 {
                VStack(spacing: 4) {
                    Button {
                        viewModel.addFriend(friend:
                            FriendsProgressCircle(id: 3, user: dummyFriend3, color: RGBColorInProgressCircle.friendColor3)
                        )    
                    } label: {
                        AddedCircleView(color: .friendGreen01)
                    }
                    Text("친구 추가")
                        .font(.callout) // 16px
                        .fontWeight(.semibold)
                }
            }
        }
    }
    var mySavingsView: some View {
        VStack {
            HStack {
                Text("나의 저축현황")
                    .font(.system(size: 22, weight: .bold))
                Spacer()
            }
            .padding(.horizontal)
            MyProgressCircle(user: dummyMy)
                .padding(.horizontal)
        }
    }
    var bottomView: some View {
        
//        @State var
    
        VStack {
            HStack {
                Text("13회")
                    .font(.callout)
                    .foregroundColor(.pointColor)
                    .bold()
                Text("저축까지 남은 시간")
                    .font(.system(size: 14))
                    .foregroundColor(.basicBlack.opacity(0.6))
            }
            Button {
                //
            } label: {
                Label {
                    Text("6일 20시간 40분")
                        .font(.callout)
                        .foregroundColor(.white)
                } icon: {
                    Image(systemName: "clock")
                        .foregroundColor(.white)
                }
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 46)
            .background(Color.basicBlack.opacity(0.3))
            .cornerRadius(30)
            .padding(.horizontal)
            // .padding(.bottom, 40)
        }
    }
}
