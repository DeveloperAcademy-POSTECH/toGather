//
//  NotificationsViewModel.swift
//  ToGather
//
//  Created by DaeSeong on 2022/06/15.
//

import SwiftUI
import Firebase

class NotificationsViewModel : ObservableObject {
    
    // MARK: - Properties
    @Published var notification = [Notification]()
    
    init() {
        fetchNotifications()
    }
    
    // MARK: - function related to firebase 
    
    // 알림들 가져오기
    func fetchNotifications() {
        do {
            let user  = try UserDefaults.standard.getObject(forKey: "User", castTo: User.self)
            let query = COLLECTION_NOTIFICATIONS
                .document(user.id!).collection("user-notifications")
                .order(by: "timestamp", descending: true)
            
            query.getDocuments { snapshot, _ in
                guard let documents = snapshot?.documents else {return}
                
                self.notification = documents.compactMap({ try? $0.data(as: Notification.self)})
                
            }
        } catch {
            print(error.localizedDescription)
        }
        
    }
    
    // 알림 업로드하기
    static func uploadNotification(toUid uid: String,type : NotificationType) {
        do {
            let user  = try UserDefaults.standard.getObject(forKey: "User", castTo: User.self)
            
            let data: [String: Any] = ["username" : user.nickname,
                                       "authPicUrl" : "",
                                       "timestamp" : Timestamp(date: Date()),
                                       "type": type.rawValue,
                                       "uid" : user.id ?? ""]
            COLLECTION_NOTIFICATIONS
                .document(uid)
                .collection("user-notifications")
                .addDocument(data: data)
            
        } catch {
            print(error.localizedDescription)
        }
        
    }
}
