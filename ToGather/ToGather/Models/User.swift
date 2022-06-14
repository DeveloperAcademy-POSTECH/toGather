//
//  User.swift
//  ToGather
//
//  Created by DaeSeong on 2022/06/08.
//

import Foundation

struct User: Codable {
    var id: String? // uuid인데 이후 Identifiable프로토콜 구현을 위해 id로 명명
    let nickname: String
    let creationDate: Date
    var isAlarmOn: Bool? = false
    var friends: [User]?
    // 친구목록은 파이어베이스에 docoument 만들어서 그안에 친구uid넣으면 될거 같습니다.
    
    enum CodingKeys: String, CodingKey {
        case id
        case nickname
        case creationDate
        case isAlarmOn
        case friends
    }
}
