//
//  Constants.swift
//  ToGather
//
//  Created by DaeSeong on 2022/06/15.
//

import Firebase
import SwiftUI

// MARK: - 파이어베이스 컬렉션 상수 모음
let COLLECTION_NOTIFICATIONS = Firestore.firestore().collection("notifications")


// MARK: - 디스플레이모드 enumer
enum DisplayMode: Int {
    case system, dark, light
    
    var colorScheme: ColorScheme? {
        switch self {
        case .system: return nil
        case .dark: return ColorScheme.dark
        case .light: return ColorScheme.light
        }
    }
    
    func setAppDisplayMode() {
        var userInterfaceStyle: UIUserInterfaceStyle
        switch self {
        case .system: userInterfaceStyle = UITraitCollection.current.userInterfaceStyle
        case .dark: userInterfaceStyle = .dark
        case .light: userInterfaceStyle = .light
        }
        let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        scene?.keyWindow?.overrideUserInterfaceStyle = userInterfaceStyle
    }
}
