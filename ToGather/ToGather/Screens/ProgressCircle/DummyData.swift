//
//  DummyData.swift
//  ToGather
//
//  Created by hyo on 2022/06/12.
//

import Foundation
import Firebase

// 더미데이터 만들기

let mySavingDate = [1,1,1,1,1,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,1]
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

let mySaving = Saving(goalProduct: Product.sampleData[0].productName,
                      goalWeeks: 25,
                      savingDayOfTheWeek: "월",
                      weekInfo: mySavingList,
                      appStartDate: "20220501")

let friendSaving1 =  Saving(goalProduct: Product.sampleData[1].productName,
                            goalWeeks: 18,
                            savingDayOfTheWeek: "화",
                            weekInfo: friendSavingList1,
                            appStartDate: "20220601")

let friendSaving2 =  Saving(goalProduct: Product.sampleData[2].productName,
                            goalWeeks: 23,
                            savingDayOfTheWeek: "수",
                            weekInfo: friendSavingList2,
                            appStartDate: "20220503")

let friendSaving3 = Saving(goalProduct: Product.sampleData[3].productName,
                           goalWeeks: 24,
                           savingDayOfTheWeek: "목",
                           appStartDate: "20220517")

let dummyMy = User(id: "0", nickname: "Miller", creationDate: "", isAlarmOn: false, saveInfo: mySaving)
let dummyFriend1 = User(id: "1", nickname: "Max", creationDate: "", isAlarmOn: false, saveInfo: friendSaving1)
let dummyFriend2 = User(id: "2", nickname: "Bit", creationDate: "", isAlarmOn: false, saveInfo: friendSaving2)
let dummyFriend3 = User(id: "3", nickname: "Eve", creationDate: "", isAlarmOn: false, saveInfo: friendSaving3)
