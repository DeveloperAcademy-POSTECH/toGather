//
//  Week.swift
//  ToGather
//
//  Created by DaeSeong on 2022/06/08.
//

import Foundation

struct ThisWeek: Identifiable, Codable {
    
    let presentWeek: Int
    var didSave: Bool
    var imageUrl: String?
    var date: String?
    var id: Int {presentWeek}
}
