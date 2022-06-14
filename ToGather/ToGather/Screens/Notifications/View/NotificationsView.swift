//
//  NotificationsView.swift
//  ToGather
//
//  Created by DaeSeong on 2022/06/14.
//

import SwiftUI
import Firebase

struct NotificationsView: View {
    var body: some View {

//NavigationView {

            ScrollView {
                LazyVStack(alignment:.leading,spacing: 0){
                    NotificaionCell(notification: Notification(username: "Max", profileImageUrl: "", timestamp: Timestamp(date:Date()) , type: .newFriend, uid: ""))

                    NotificaionCell(notification: Notification(username: "Max", profileImageUrl: "", timestamp: Timestamp(date:Date()) , type: .mySavingDay, uid: ""))
                    NotificaionCell(notification: Notification(username: "Max", profileImageUrl: "", timestamp: Timestamp(date:Date()) , type: .friendSavigState, uid: ""))
                
                    NotificaionCell(notification: Notification(username: "Max", profileImageUrl: "", timestamp: Timestamp(date:Date()) , type: .mySavingDay, uid: ""))
                    
                    NotificaionCell(notification: Notification(username: "Max", profileImageUrl: "", timestamp: Timestamp(date:Date()) , type: .friendSavigState, uid: ""))
                
            }

                
            }
          
      //  }
    }
}

struct NotificationsView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationsView()
    }
}
