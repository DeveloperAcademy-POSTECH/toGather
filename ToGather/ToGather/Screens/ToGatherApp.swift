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
    init() {
        FirebaseApp.configure()
        
        // TODO: - 파이어베이스 연동과정에서 제거예정
//        do {
//        try UserDefaults.standard.setObject(User(id: "125",
//                                       nickname: "miller",
//                                       creationDate: Date(),
//                                                 isAlarmOn: false), forKey: "User")
//        } catch {
//            print(error.localizedDescription)
//
//        }
        }
    var body: some Scene {
        WindowGroup {
//            LastOnboardingView()
//                .environmentObject(UserViewModel())
            //MainView()
            StartView()
                .environmentObject(userViewModel)
        }
    }
}

