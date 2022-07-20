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
    @State var showSheet: Bool = true
    @StateObject var viewModel = MainViewModel()
    
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
            .halfsheet(showSheet: $showSheet) {
                VStack(spacing: 0) {
                    HStack {
                        VStack(alignment: .leading, spacing: 0) {
                            HStack(spacing: 2) {
                                Text(dummyFriend1.nickname)
                                    .foregroundColor(Color.pointColor)
                                Text("에게 친구신청이 왔어요")
                                    .foregroundColor(Color.basicBlack)
                            }
                            .font(.system(size: 22, weight: .bold))
                            .padding(.bottom, 12)
                            Text("같이 저축현황을 공유할까요?")
                                .font(.system(size: 18))
                                .foregroundColor(Color.basicBlack)
                                .padding(.bottom, 48)
                        }
                        .padding(.leading, 20)
                        Spacer()
                    }
                    AddingFriendProgressCircle(id: 1, user: dummyFriend1, color: RGBColorInProgressCircle.myColor)
                        .padding(.bottom, 21)
                    HStack(spacing: 4) {
                        Text("매주")
                            .fontWeight(.bold)
                        Text("\(dummyFriend1.saveInfo.savingDayOfTheWeek)요일")
                            .fontWeight(.bold)
                        Text("\(dummyFriend1.saveInfo.savingAmountOfWeek, specifier: "%3.1f")만원")
                            .fontWeight(.bold)
                            .foregroundColor(Color.pointColor)
                    }
                    .font(.system(size: 18))
                    HStack {
                        Button(
                            action: {
                                
                            }, label: {
                                Text("아니요")
                            })
                        Button(
                            action: {
                                
                            }, label: {
                                Text("공유할게요")
                            })
                    }
                }
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
                NavigationLink(destination: FrSavingStatusNavigationView(user: friendSaving.user, colorRGB: RGBColorInProgressCircle.colorList[Int(friendSaving.id)]).navigationTitle("알림")
                    .navigationBarHidden(true)) {
                        
                        //                NavigationLink(destination: EmptyView()) {
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
        VStack(spacing: 0) {
            HStack {
                Text("나의 저축현황")
                    .font(.system(size: 22, weight: .bold))
                Spacer()
                NavigationLink(destination: SavingStatusNavigationView().navigationBarHidden(true)) {
                    HStack(spacing: 4) {
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

extension View {
    
    func halfsheet<SheetView: View>(showSheet: Binding<Bool>, @ViewBuilder sheetView: @escaping ()->SheetView)->some View {
        return self
            .background(
                HalfSheetHelper(sheetView: sheetView(), showSheet: showSheet)
            )
    }
}

struct HalfSheetHelper<SheetView: View>: UIViewControllerRepresentable {
    var sheetView: SheetView
    @Binding var showSheet: Bool
    
    let controller = UIViewController()
    
    func makeUIViewController(context: Context) -> UIViewController {
        controller.view.backgroundColor = .clear
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        if showSheet {
            let sheetController = CustomHostingController(rootView: sheetView)
            uiViewController.present(sheetController, animated: true) {
                DispatchQueue.main.async {
                    self.showSheet.toggle()
                }
            }
        }
    }
}

class CustomHostingController<Content: View>: UIHostingController<Content> {
    override func viewDidLoad() {
        if let presentationController = presentationController as? UISheetPresentationController {
            presentationController.detents = [
                .medium(),
                .large()
            ]
            
            presentationController.prefersGrabberVisible = true
        }
    }
}
