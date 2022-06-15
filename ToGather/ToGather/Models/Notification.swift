//
//  Notification.swift
//  ToGather
//
//  Created by DaeSeong on 2022/06/14.
//

import FirebaseFirestoreSwift
import Firebase

    // MARK: - Notification Model
struct Notification : Identifiable, Decodable {
    
    @DocumentID var id: String? // 유저 id
    let username: String
    let authPicUrl: String
    let timestamp: Timestamp
    let type: NotificationType
    let uid: String  // 유저 id
}
    // MARK: - NotificationType enumeration
enum NotificationType: Int, Decodable {
    case newFriend
    case mySavingDay
    case friendSavigState
    
    var notificationMessage: String {
        switch self {
        case .newFriend: return "liked one of yout posts"
        case .mySavingDay: return "commented on one of your posts"
        case .friendSavigState: return "started following you"
        }
    }
}

