//
//  Product.swift
//  ToGather
//
//  Created by DaeSeong on 2022/06/08.
//

import Foundation

struct Product : Codable {
    let productName: String
    let productPrice: Double
    let imageUrl: String
}

extension Product {
    static let sampleData: [Product] = [
      Product(productName: "imac", productPrice: 180, imageUrl: "imac"),
      Product(productName: "iPadmini", productPrice: 70, imageUrl: "iPadmini"),
      Product(productName: "iphone13", productPrice: 100, imageUrl: "iphone13"),
     Product(productName: "macbook", productPrice: 200, imageUrl: "macbook")
    ]
}
