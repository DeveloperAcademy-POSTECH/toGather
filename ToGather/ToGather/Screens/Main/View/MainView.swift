//
//  MainView.swift
//  ToGather
//
//  Created by DaeSeong on 2022/06/09.
//

import SwiftUI

let userViewModel = UserViewModel()

struct MainView: View {
    @State var friendsCount  = 0
    @StateObject var viewModel = MainViewModel()
    
    @EnvironmentObject var userViewModel: UserViewModel
    var user: User = dummyMy //{userViewModel.userData}
    
    var saving: Saving {user.saveInfo}
   
    // product
    var productImageUrl: String {user.saveInfo.goalProduct.imageUrl}
    var productPrice: Double {user.saveInfo.goalProduct.productPrice}
    
    // time
    var lastDate: String {user.saveInfo.lastDate}
    var startDate: String {user.saveInfo.startDate}
    var savingDay: String {user.saveInfo.savingDayOfTheWeek}
    var savingAmountOfWeek: Double {user.saveInfo.savingAmountOfWeek}
    var currentWeek: Int {user.saveInfo.currentWeek}
    @State var deadLine = ""
    
    // money
    var totalSavingAmount: Double {user.saveInfo.totalSavingAmount}
    var goalSavingAmount: Double {user.saveInfo.goalSavingAmount}
    
    // progress
    var totalFailedNum: Int {user.saveInfo.totalFailedNum}
    var totalSavedNum: Int {user.saveInfo.totalSavedNum}
    var progressPercent: Double {user.saveInfo.progressPercent}

    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    init() {
        // 네비게이션 타이틀 사이즈 조절
        UINavigationBar.appearance().largeTitleTextAttributes = [.font : UIFont.systemFont(ofSize: 24,weight: .bold)]
        }
  
    let addFriendsColor: [Color] = [.friendRed01, .friendPurple01, .friendGreen01]
    
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
        MainView().environmentObject(userViewModel)
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
            ForEach(viewModel.getFriendList()) { friendSaving in
                NavigationLink(destination: SavingStatusView()) {
                    friendSaving
                }
                .buttonStyle(PlainButtonStyle())
            }

            VStack(spacing: 4) {
                NavigationLink(destination: FriendAdditionView(onboardingViewModel: OnBoardingViewModel())) {
                    AddedCircleView(color: addFriendsColor[viewModel.getFriendList().count])
                }
                Text(viewModel.getFriendList().isEmpty ? "친구랑 같이 저축하기" : "친구 추가")
                    .font(.callout) // 16px
                    .fontWeight(.semibold)
            }
        }
    }
    
    var mySavingsView: some View {
        VStack {
            HStack {
                Text("나의 저축현황")
                    .font(.system(size: 22, weight: .bold))
                Spacer()

                NavigationLink(destination: SavingStatusNavigationView()
                .navigationTitle("알림")
                .navigationBarHidden(true)){
                Text("상세보기 􀯻")
                    .font(.system(size: 14))
                    .foregroundColor(.basicBlack.opacity(0.6))
                    .offset(y:20)
                }
            }
            .padding(.horizontal)
            MyProgressCircle(user: user)
                .padding(.horizontal)
        }
    }
    

    var bottomView: some View {
        VStack {
                Text("\(currentWeek)회 ")
                    .font(.callout)
                    .foregroundColor(.pointColor)
                    .bold()
                 + Text("저축까지 남은 시간")
                    .font(.system(size: 14))
                    .foregroundColor(.basicBlack.opacity(0.6))
            
            NavigationLink(destination: SavingRecordView().navigationBarBackButtonHidden(true).navigationBarHidden(true)) {
                Label {
                    Text("\(deadLine)")
                        .font(.callout)
                        .foregroundColor(.white)
                        .onReceive(timer) {_ in
                            deadLine = getRemainTime(firstSavingDate: startDate) }
                } icon: {
                    Image(systemName: "clock")
                        .foregroundColor(.white)
                }
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 46)
                .background(Color.basicBlack.opacity(0.3))
                .cornerRadius(30)
                .padding(.horizontal)
            }
        }
    }
}
