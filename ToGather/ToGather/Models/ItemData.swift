//
//  itemData.swift
//  ToGather
//
//  Created by yeongwoocho on 2022/06/14.
//

import Foundation

enum ItemData: CaseIterable {
    case firstHeadline
    case secondHeadline
    case thirdHeadline
    case firstItem
    case secondItem
    case thirdItem
    case fourthItem
    case fifthItem
    case sixthItem
    case seventhItem
    case eighthItem
    func index() -> Int {
        switch self {
        case .firstItem:
            return 1
        case .secondItem:
            return 2
        case .thirdItem:
            return 3
        case .fourthItem:
            return 4
        case .fifthItem:
            return 5
        case .sixthItem:
            return 6
        case .seventhItem:
            return 7
        case .eighthItem:
            return 8
        default:
            return -1
        }
    }
    func title() -> String {
        switch self {
        case .firstHeadline:
            return "100만원"
        case .secondHeadline:
            return "200만원"
        case .thirdHeadline:
            return "300만원"
        case .firstItem:
            return "airpodsPro"
        case .secondItem:
            return "appleWatch"
        case .thirdItem:
            return "iPadmini"
        case .fourthItem:
            return "iphone13"
        case .fifthItem:
            return "macbook"
        case .sixthItem:
            return "imac"
        case .seventhItem:
            return "macbookPro"
        case .eighthItem:
            return "macStudio"
        }
    }
    func price() -> String {
        switch self {
        case .firstItem:
            return "300,000"
        case .secondItem:
            return "500,000"
        case .thirdItem:
            return "700,000"
        case .fourthItem:
            return "1,000,000"
        case .fifthItem:
            return "1,300,000"
        case .sixthItem:
            return "1,800,000"
        case .seventhItem:
            return "2,500,000"
        case .eighthItem:
            return "3,500,000"
        default:
            return ""
        }
    }
}
