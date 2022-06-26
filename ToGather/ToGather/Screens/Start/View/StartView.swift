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
    
    var body: some View {
        MainView()
            .fullScreenCover(isPresented: self.$onboardingViewModel.isFirstOn) {
                GoalSetting(onboardingViewModel: onboardingViewModel)
            }
            .onAppear{
                if !onboardingViewModel.isFirstOn {
                    
                    FirebaseManager.shared.fetchUser(userId: "85726A") { user in
                        userViewModel.userData = user

                        print("hiroo:\(user.saveInfo.goalProduct)")
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
