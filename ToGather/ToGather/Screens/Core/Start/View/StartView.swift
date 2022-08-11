//
//  StartView.swift
//  ToGather
//
//  Created by yudonlee on 2022/06/16.
//

import SwiftUI
import Firebase

struct StartView: View {
    @EnvironmentObject var userViewModel: UserViewModel
    @AppStorage("isVisited") var isFirstOn = !UserDefaults.standard.bool(forKey: "isVisited")  // 처음에 자동으로 초기화된 값이 false라서 이렇게 작성함. true로 들어가도록.
    var userId : String? = UserDefaults.standard.string(forKey: "User")
    var body: some View {
        MainView()
            .fullScreenCover(isPresented: self.$isFirstOn) {
                GoalSetting()
            }
            .onAppear{
                if !isFirstOn {
                    FirebaseManager.shared.requestUser(userId: userId ?? "") { user in
                        userViewModel.userData = user
                        userViewModel.requestAuthPics()
                        userViewModel.requestFriendProgressCircles()
                        
                    }
                }
            }
    }
}

struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        StartView()
    }
}
