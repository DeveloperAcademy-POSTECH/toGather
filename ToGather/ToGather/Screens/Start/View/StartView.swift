//
//  StartView.swift
//  ToGather
//
//  Created by yudonlee on 2022/06/16.
//

import SwiftUI

struct StartView: View {
    @EnvironmentObject var userViewModel: UserViewModel
    @StateObject var onboardingViewModel = OnBoardingViewModel()
    var userId : String? = UserDefaults.standard.string(forKey: "User")
    var body: some View {
        MainView()
            .fullScreenCover(isPresented: self.$onboardingViewModel.isFirstOn) {
                GoalSetting(onboardingViewModel: onboardingViewModel)
            }
            .onAppear{
                print("파베호출")
                if !onboardingViewModel.isFirstOn {
                     FirebaseManager.shared.fetchUser(userId: userId ?? "") { user in
                        userViewModel.userData = user
                        userViewModel.fetchAuthPics()
                          
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
