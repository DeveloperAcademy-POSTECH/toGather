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
            let notificationQuery = COLLECTION_NOTIFICATIONS
                .document(user.id!).collection("user-notifications")
                .order(by: "timestamp", descending: true)
            
            notificationQuery.getDocuments { snapshot, _ in
                guard let documents = snapshot?.documents else {return}
                
                self.notification = documents.compactMap({ try? $0.data(as: Notification.self)})
                
            }
        } catch {
            print(error.localizedDescription)
        }
        
    }
    
    // TODO: - 매개변수 수정 필요
    // 알림 업로드하기
    static func uploadNotification(/**toUid uid: String,**/type : NotificationType) {
        do {
            let user  = try UserDefaults.standard.getObject(forKey: "User", castTo: User.self)
            
            let notificationData: [String: Any] = ["username" : user.nickname,
                                       "authPicUrl" : "",
                                       "timestamp" : Timestamp(date: Date()),
                                       "type": type.rawValue,
                                       "uid" : user.id ?? ""]
            COLLECTION_NOTIFICATIONS
                .document()
                .collection("user-notifications")
                .addDocument(data: notificationData)
            
        } catch {
            print(error.localizedDescription)
        }
        
    }
}
