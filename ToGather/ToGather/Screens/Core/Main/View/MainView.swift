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
    
    var currentDidSave: Bool {saving.weekInfo[currentWeek - 1].didSave}
    
    // product
    var productImageUrl: String {Product.productDictionary[user.saveInfo.goalProduct]?.imageUrl ?? ""}
    var productPrice: Double {Product.productDictionary[user.saveInfo.goalProduct]?.productPrice ?? 0}
    
    // time
    var lastDate: String {user.saveInfo.lastDate}
    var startDate: String {user.saveInfo.startDate}
    var savingDay: String {user.saveInfo.savingDayOfTheWeek}
    var savingAmountOfWeek: Double {user.saveInfo.savingAmountOfWeek}
    var currentWeek: Int {user.saveInfo.currentWeek}
    @State var deadLine = ""
    var currentWeekEndDate: Date {user.saveInfo.currentWeekEndDate}
    
    // money
    var totalSavingAmount: Double {user.saveInfo.totalSavingAmount}
    var goalSavingAmount: Double {user.saveInfo.goalSavingAmount}
    
    // progress
    var totalFailedNum: Int {user.saveInfo.totalFailedNum}
    var totalSavedNum: Int {user.saveInfo.totalSavedNum}
    var progressPercent: Double {user.saveInfo.progressPercent}
    
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
                NavigationLink(destination: FrSavingStatusNavigationView(user: friendSaving.user, colorRGB: RGBColorInProgressCircle.colorList[Int(friendSaving.id)]).navigationTitle("알림")
                    .navigationBarHidden(true)) {
                    
//                NavigationLink(destination: EmptyView()) {
                    friendSaving
                }
                .buttonStyle(PlainButtonStyle())
            }
            
            if userViewModel.friendProgressCircles.count < 3 {
                VStack(spacing: 4) {
                    NavigationLink(destination: FriendAdditionView( isPresentationMode: .constant(true))) {
                        AddedCircleView(color: addFriendsColor[userViewModel.friendProgressCircles.count])
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
            Text("\(currentWeek)회 ")
                .font(.callout)
                .foregroundColor(.pointColor)
                .bold()
            + Text("저축까지 남은 시간")
                .font(.system(size: 14))
                .foregroundColor(.basicBlack.opacity(0.6))
                        
            if isSavingDay(currentWeekEndDate: currentWeekEndDate) && currentDidSave == false {
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
                            deadLine = getRemainTime(currentWeekEndDate: currentWeekEndDate)}
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
