//
//  Week.swift
//  ToGather
//
//  Created by DaeSeong on 2022/06/08.
//

import Foundation

struct ThisWeek: Identifiable, Codable {
    
    let presentWeek: Int
    let didSave: Bool
    var imageUrl : String? = ""
    var id: Int {presentWeek}
}
