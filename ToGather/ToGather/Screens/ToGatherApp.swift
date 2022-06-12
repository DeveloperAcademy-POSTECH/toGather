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
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
