//
//  StartView.swift
//  ToGather
//
//  Created by yudonlee on 2022/06/16.
//

import SwiftUI
import Firebase

struct StartView: View {
    @EnvironmentObject var onboardingViewModel:OnBoardingViewModel
    @EnvironmentObject var userViewModel: UserViewModel
    
    var userId : String? = UserDefaults.standard.string(forKey: "User")
    var body: some View {
        MainView()
            .fullScreenCover(isPresented: self.$onboardingViewModel.isFirstOn) {
                GoalSetting()
            }
            .onAppear{
                print("파베호출")
                if !onboardingViewModel.isFirstOn {
                     FirebaseManager.shared.fetchUser(userId: userId ?? "") { user in
                        userViewModel.userData = user
                        userViewModel.fetchAuthPics()
                         userViewModel.fetchfriends()
                          
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
