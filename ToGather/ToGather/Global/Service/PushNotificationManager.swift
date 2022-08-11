//
//  PushNotificationManager.swift
//  ToGather
//
//  Created by DaeSeong on 2022/08/11.
//

import Foundation

struct PushNotificationManager {
    func sendPushNotification(to token: String, title: String, body: String) {
        let server_key = ""
        let urlString = "https://fcm.googleapis.com/fcm/send"
        let url = NSURL(string: urlString)!
        let paramString: [String : Any] = ["to" : token,
                                           "notification" : ["title" : title, "body" : body],
                                           "data" : ["user" : "test_id"]
        ]
        
    
    }

}
