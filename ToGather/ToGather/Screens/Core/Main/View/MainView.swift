//
//  MainView.swift
//  ToGather
//
//  Created by DaeSeong on 2022/06/09.
//

import SwiftUI

let userViewModel = UserViewModel()

struct MainView: View {
    // MARK: - Properties
    @State var friendsCount  = 0
    @EnvironmentObject var userViewModel: UserViewModel
    var user: User {userViewModel.userData}
    var saving: Saving {user.saveInfo}
        
    @State var deadLine = ""
        
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    let addFriendsColor: [Color] = [.friendRed01, .friendPurple01, .friendGreen01]

    // MARK: - Init
    init() {
        // 네비게이션 타이틀 사이즈 조절
        UINavigationBar.appearance().largeTitleTextAttributes = [.font : UIFont.systemFont(ofSize: 24,weight: .bold)]
    }
    
    // MARK: - Body
    var body: some View {
        NavigationView {
            VStack {
                friendsSavingsView
                    .padding()
                Divider()
                    .padding(.horizontal)
                    .padding(.bottom, 25)
                
                mySavingsView
                Text("\(user.saveInfo.currentWeek)")
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
    // MARK: - Previews
struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView().environmentObject(userViewModel)
    }
}

    // MARK: - Extensions
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
            
            NavigationLink {
                SettingView()
                    .navigationBarHidden(true)
            } label: {
                Image(systemName: "gear")
            }
            .foregroundColor(.basicBlack.opacity(0.4))
        }
    }
    
    var friendsSavingsView: some View {
        HStack(spacing: 26) {
            ForEach(userViewModel.friendProgressCircles) { friendSaving in
                NavigationLink(destination: FrSavingStatusNavigationView(user: friendSaving.user, colorRGB: Color.friendColors[Int(friendSaving.id)]).navigationTitle("알림")
                    .navigationBarHidden(true)) {
                    
//                NavigationLink(destination: EmptyView()) {
                    friendSaving
                }
                .buttonStyle(PlainButtonStyle())
            }
            
            if userViewModel.friendProgressCircles.count < 3 {
                let count = userViewModel.friendProgressCircles.count
                VStack(spacing: 4) {
                    CustomNavigationLink(destination: FriendAdditionViewFromMain()) {
                        AddedCircleView(color: addFriendsColor[count])
                    }
                    Text(userViewModel.friendProgressCircles.isEmpty ? "친구랑 같이 저축하기" : "친구 추가")
                        .font(.callout) // 16px
                        .fontWeight(.semibold)
                }
            }
        }
    }
    
    var mySavingsView: some View {
        VStack(spacing: 0){
            HStack {
                Text("나의 저축현황")
                    .font(.system(size: 22, weight: .bold))
                Spacer()
                NavigationLink(destination: SavingStatusNavigationView().navigationBarHidden(true)){
                    HStack(spacing: 4){
                        Text("상세보기")
                            .font(.system(size: 14))
                            .foregroundColor(.basicBlack.opacity(0.6))
                        Image(systemName: "chevron.forward")
                            .resizable()
                            .frame(width: 6, height: 10)
                            .foregroundColor(.basicBlack.opacity(0.6))
                    } .offset(y:20)
                }
                
            }
            .padding(.horizontal)
            MyProgressCircle(user: user)
                .padding(.horizontal)
            
        }
    }
    
    var bottomView: some View {
        VStack {
            Text("\(user.saveInfo.currentWeek)회 ")
                .font(.callout)
                .foregroundColor(.pointColor)
                .bold()
            + Text("저축까지 남은 시간")
                .font(.system(size: 14))
                .foregroundColor(.basicBlack.opacity(0.6))
                        
            if user.saveInfo.canSaving() {
                NavigationLink(destination: SavingRecordView().navigationBarBackButtonHidden(true).navigationBarHidden(true)) {
                    Text("오늘은 저축하는 날이에요")
                        .font(.callout)
                        .foregroundColor(.white)
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 46)
                        .background(Color.pointColor)
                        .cornerRadius(30)
                        .padding(.horizontal)
                        
                }
            } else {
                Label {
                    Text("\(deadLine)")
                        .onReceive(timer) {_ in
                            // saving 내부의 currentWeek를 재할당.
                            deadLine = getRemainTime(from: user.saveInfo.currentWeekEndDate)
                        }
                } icon: {
                    Image(systemName: "clock")
                        .foregroundColor(.white)
                }
                .font(.callout)
                .foregroundColor(.white)
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 46)
                .background(Color.black03)
                .cornerRadius(30)
                .padding(.horizontal)
            }
        }
    }
    
    
}
