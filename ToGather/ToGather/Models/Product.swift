//
//  Product.swift
//  ToGather
//
//  Created by DaeSeong on 2022/06/08.
//

import Foundation

struct Product {
    let productName: String
    let productPrice: Double
    let imageUrl: String
}

extension Product {
    static let sampleData: [Product] = [
      Product(productName: "imac", productPrice: 180, imageUrl: "imac"),
      Product(productName: "ipad", productPrice: 70, imageUrl: "ipad"),
      Product(productName: "iphone", productPrice: 100, imageUrl: "iphone"),
     Product(productName: "macbook", productPrice: 200, imageUrl: "macbook")
    ]
}
