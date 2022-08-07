//
//  ToGatherApp.swift
//  ToGather
//
//  Created by yudonlee on 2022/06/09.
//

import SwiftUI
import FirebaseCore

@main
struct ToGatherApp: App {
    @StateObject var userViewModel = UserViewModel()
    @StateObject var onboardingViewModel = OnBoardingViewModel()
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            StartView()
                .environmentObject(userViewModel)
                .environmentObject(onboardingViewModel)
            
        }
    }
}   
