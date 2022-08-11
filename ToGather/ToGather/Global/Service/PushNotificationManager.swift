//
//  PushNotificationManager.swift
//  ToGather
//
//  Created by DaeSeong on 2022/08/11.
//

import Foundation

//struct PushNotificationManager {
//    func sendPushNotification(to token: String, title: String, body: String) {
//        let server_key = ""
//        let urlString = "https://fcm.googleapis.com/fcm/send"
//        let url = NSURL(string: urlString)!
//        let paramString: [String : Any] = ["to" : token,
//                                           "notification" : ["title" : title, "body" : body],
//                                           "data" : ["user" : "test_id"]
//        ]
//
//
//    }
//
//}

class PushNotificationManager {
    func sendPushNotification(to token: String, title: String, body: String) {
        let server_key = "AAAA4DyC34g:APA91bFrJPkuapSLQXN92-ry6UDIhULukpP_nsRJyfnI_-zgGVIcuisReSdHjav520_sKVe37G7UibBmdFNunRtNaWbac3A72Sb30ZaGgDC4MhSbGQKv51t_mfmVInHOhD_Yv4PrHy4r"
        let urlString = "https://fcm.googleapis.com/fcm/send"
        let url = NSURL(string: urlString)!
        let paramString: [String : Any] = ["to" : token,
                                           "notification" : ["title" : title, "body" : body],
                                           "data" : ["user" : "test_id"]
        ]
        let request = NSMutableURLRequest(url: url as URL)
        request.httpMethod = "POST"
        request.httpBody = try? JSONSerialization.data(withJSONObject:paramString, options: [.prettyPrinted])
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("key=\(server_key)", forHTTPHeaderField: "Authorization")
        let task =  URLSession.shared.dataTask(with: request as URLRequest)  { (data, response, error) in
            do {
                if let jsonData = data {
                    if let jsonDataDict  = try JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions.allowFragments) as? [String: AnyObject] {
                        NSLog("Received data:\n\(jsonDataDict))")
                    }
                }
            } catch let err as NSError {
                print(err.debugDescription)
            }
        }
        task.resume()
    }
}
