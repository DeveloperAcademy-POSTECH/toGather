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
    let check: Int
}

let saveList: [Week] = [Week(id: 1, check: 1), Week(id: 2, check: 1), Week(id: 3, check: 1), Week(id: 4, check: 0), Week(id: 5, check: 1),
                        Week(id: 6, check: 1), Week(id: 7, check: 1), Week(id: 8, check: 1), Week(id: 9, check: 0), Week(id: 10, check: 1),
                        Week(id: 11, check: 1), Week(id: 12, check: 0), Week(id: 13, check: 0), Week(id: 14, check: 0), Week(id: 15, check: 1),
                        Week(id: 16, check: 1), Week(id: 17, check: 0), Week(id: 18, check: 1), Week(id: 19, check: 0), Week(id: 20, check: 1),
                        Week(id: 21, check: 1), Week(id: 22, check: 1), Week(id: 23, check: 1), Week(id: 24, check: 0), Week(id: 25, check: 1)]

let product = Product(productName: "imac", productPrice: 180, imageUrl: "imac")

let currentWeek = 14
