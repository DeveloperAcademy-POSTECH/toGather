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
        Product(productName: "ipad", productPrice: 70, imageUrl: "ipad"),
        Product(productName: "iphone", productPrice: 100, imageUrl: "iphone"),
        Product(productName: "macbook", productPrice: 200, imageUrl: "macbook")
    ]
    static let productDictionary: [String:Product] = [
        "airpodsPro" : Product(productName: "airpodsPro", productPrice: 30, imageUrl: "airpodsPro"),
        "appleWatch" : Product(productName: "appleWatch", productPrice: 50, imageUrl: "appleWatch"),
        "iPadmini" : Product(productName: "iPadmini", productPrice: 70, imageUrl: "iPadmini"),
        "iphone13" : Product(productName: "iphone13", productPrice: 100, imageUrl: "iphone13"),
        "macbook" : Product(productName: "macbook", productPrice: 130, imageUrl: "macbook"),
        "imac": Product(productName: "imac", productPrice: 180, imageUrl: "imac"),
        "macbookPro": Product(productName: "macbookPro", productPrice: 250, imageUrl: "macbookPro"),
        "macStudio": Product(productName: "macStudio", productPrice: 350, imageUrl: "macStudio")
    ]
}

