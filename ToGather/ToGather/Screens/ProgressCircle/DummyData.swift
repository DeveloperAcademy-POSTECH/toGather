//
//  DummyData.swift
//  ToGather
//
//  Created by hyo on 2022/06/12.
//

import Foundation

// 더미데이터
struct Week: Identifiable {
    let id: Int
    let didSave: Int
}

let saveList: [ThisWeek] = [ThisWeek(presentWeek: 1, didSave: true), ThisWeek(presentWeek: 2, didSave: true), ThisWeek(presentWeek: 3, didSave: true)
                            , ThisWeek(presentWeek: 4, didSave: false), ThisWeek(presentWeek: 5, didSave: true),ThisWeek(presentWeek: 6, didSave: true)
                            , ThisWeek(presentWeek: 7, didSave: true), ThisWeek(presentWeek: 8, didSave: true), ThisWeek(presentWeek: 9, didSave: false)
                            , ThisWeek(presentWeek: 10, didSave: true), ThisWeek(presentWeek: 11, didSave: true), ThisWeek(presentWeek: 12, didSave: false)
                            , ThisWeek(presentWeek: 13, didSave: false), ThisWeek(presentWeek: 14, didSave: false), ThisWeek(presentWeek: 15, didSave: true)
                            , ThisWeek(presentWeek: 16, didSave: true), ThisWeek(presentWeek: 17, didSave: false), ThisWeek(presentWeek: 18, didSave: true)
                             , ThisWeek(presentWeek: 19, didSave: false), ThisWeek(presentWeek: 20, didSave: true), ThisWeek(presentWeek: 21, didSave: true)
                             , ThisWeek(presentWeek: 22, didSave: true), ThisWeek(presentWeek: 23, didSave: true), ThisWeek(presentWeek: 24, didSave: false)
                             , ThisWeek(presentWeek: 25, didSave: true)]

let product = Product(productName: "imac", productPrice: 180, imageUrl: "imac")

let currentWeek = 14
