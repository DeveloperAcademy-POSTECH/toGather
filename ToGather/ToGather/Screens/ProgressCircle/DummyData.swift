//
//  DummyData.swift
//  ToGather
//
//  Created by hyo on 2022/06/12.
//

import Foundation
import Firebase

// 더미데이터 만들기

let mySavingDate = [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,1]
let friendSavingDate1 = [1,1,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,1]
let friendSavingDate2 = [1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,1,1,1,0,1,1,1,1]
let friendSavingDate3 = [1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,1]

func makeSaveList(data: [Int]) -> [ThisWeek] {
    var k = 1
    var result: [ThisWeek] = []
    for i in data {
        result.append(ThisWeek(presentWeek: k, didSave: (i == 1 ? true : false)))
        k += 1
    }
    return result
}

let mySavingList = makeSaveList(data: mySavingDate)
let friendSavingList1 = makeSaveList(data: friendSavingDate1)
let friendSavingList2 = makeSaveList(data: friendSavingDate2)
let friendSavingList3 = makeSaveList(data: friendSavingDate3)

let mySaving = Saving(goalProduct: Product.sampleData[0],
                      uid: "0",
                      goalWeeks: 25,
                      startDate: "20220603",
                      savingDayOfTheWeek: "월",
                     weekInfo: mySavingList)

let friendSaving1 =  Saving(goalProduct: Product.sampleData[1],
                           uid: "1",
                           goalWeeks: 18,
                           startDate: "20220601",
                           savingDayOfTheWeek: "화",
                           weekInfo: friendSavingList1)

let friendSaving2 =  Saving(goalProduct: Product.sampleData[2],
                            uid: "2",
                            goalWeeks: 23,
                            startDate:  "20220501",
                            savingDayOfTheWeek: "수",
                            weekInfo: friendSavingList2)

let friendSaving3 = Saving(goalProduct: Product.sampleData[3],
                           uid: "3",
                           goalWeeks: 24,
                           startDate: "202205010",
                           savingDayOfTheWeek: "목",
                           weekInfo: friendSavingList3)

let dummyMy = User(id: "0", nickname: "Miller", creationDate: Date(), isAlarmOn: false, saveInfo: mySaving)
let dummyFriend1 = User(id: "1", nickname: "Lance", creationDate:  Date(), isAlarmOn: false, saveInfo: friendSaving1)
let dummyFriend2 = User(id: "2", nickname: "Neal", creationDate:  Date(), isAlarmOn: false, saveInfo: friendSaving2)
let dummyFriend3 = User(id: "3", nickname: "Eve", creationDate:  Date(), isAlarmOn: false, saveInfo: friendSaving3)
