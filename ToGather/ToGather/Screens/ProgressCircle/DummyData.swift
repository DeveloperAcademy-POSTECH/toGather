//
//  DummyData.swift
//  ToGather
//
//  Created by hyo on 2022/06/12.
//

import Foundation
import Firebase

 let saveList: [ThisWeek] = [ThisWeek(presentWeek: 1, didSave: true),
                            ThisWeek(presentWeek: 2, didSave: true),
                            ThisWeek(presentWeek: 3, didSave: true),
                            ThisWeek(presentWeek: 4, didSave: false),
                            ThisWeek(presentWeek: 5, didSave: true),
                            ThisWeek(presentWeek: 6, didSave: true),
                            ThisWeek(presentWeek: 7, didSave: true),
                            ThisWeek(presentWeek: 8, didSave: true),
                            ThisWeek(presentWeek: 9, didSave: false),
                            ThisWeek(presentWeek: 10, didSave: true),
                            ThisWeek(presentWeek: 11, didSave: true),
                            ThisWeek(presentWeek: 12, didSave: false),
                            ThisWeek(presentWeek: 13, didSave: false),
                            ThisWeek(presentWeek: 14, didSave: false),
                            ThisWeek(presentWeek: 15, didSave: true),
                            ThisWeek(presentWeek: 16, didSave: true),
                            ThisWeek(presentWeek: 17, didSave: false),
                            ThisWeek(presentWeek: 18, didSave: true),
                            ThisWeek(presentWeek: 19, didSave: false),
                            ThisWeek(presentWeek: 20, didSave: true),
                            ThisWeek(presentWeek: 21, didSave: true),
                            ThisWeek(presentWeek: 22, didSave: true),
                            ThisWeek(presentWeek: 23, didSave: true),
                            ThisWeek(presentWeek: 24, didSave: false), 
                            ThisWeek(presentWeek: 25, didSave: true)]


let currentWeek = 14

struct DummyData {
    static let sampleSavings : [Saving] = [
        Saving(goalProduct: Product.sampleData[0],
               uid: "0",
               goalWeeks: 25,
               startDate: Timestamp(date: Date()),
               savingDayOfTheWeek: "Monday",
              weekInfo: saveList),
        Saving(goalProduct: Product.sampleData[1],
               uid: "1",
               goalWeeks: 25,
               startDate: Timestamp(date: Date()),
               savingDayOfTheWeek: "Sunday",
               weekInfo: saveList),
        Saving(goalProduct: Product.sampleData[2],
               uid: "2",
               goalWeeks: 25,
               startDate: Timestamp(date: Date()),
               savingDayOfTheWeek: "Tuesday",
               weekInfo: saveList),
        Saving(goalProduct: Product.sampleData[3],
               uid: "3",
               goalWeeks: 25,
               startDate: Timestamp(date: Date()),
               savingDayOfTheWeek: "Thursday",
               weekInfo: saveList)
    ]
//    static let sampleUsers: [User] = [
//        User(id: "0", nickname: "Miller", creationDate: Date(), isAlarmOn: false),
//        User(id: "1", nickname: "Lance", creationDate:  Date(), isAlarmOn: false),
//        User(id: "2", nickname: "Neal", creationDate:  Date(), isAlarmOn: false),
//        User(id: "3", nickname: "Eve", creationDate:  Date(), isAlarmOn: false)
//
//
//    ]
}
