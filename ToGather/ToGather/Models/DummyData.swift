//
//  DummyData.swift
//  ToGather
//
//  Created by hyo on 2022/06/12.
//

import Foundation
import Firebase


struct DummyData {
    // 더미데이터 만들기

    static let mySavingDate = [1,1,1,1,1,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,1]
    static let friendSavingDate1 = [1,1,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,1]
    static let friendSavingDate2 = [1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,1,1,1,0,1,1,1,1]
    static let friendSavingDate3 = [1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,1]
    
    static func makeSaveList(data: [Int]) -> [ThisWeek] {
        var k = 1
        var result: [ThisWeek] = []
        for i in data {
            result.append(ThisWeek(presentWeek: k, didSave: (i == 1 ? true : false)))
            k += 1
        }
        return result
    }
    
    static let mySavingList = makeSaveList(data: mySavingDate)
    static let friendSavingList1 = makeSaveList(data: friendSavingDate1)
    static let friendSavingList2 = makeSaveList(data: friendSavingDate2)
    static let friendSavingList3 = makeSaveList(data: friendSavingDate3)

    static let mySaving = Saving(goalProduct: Product.sampleData[0].productName,
                          goalWeeks: 25,
                          savingDayOfTheWeek: "월",
                          weekInfo: mySavingList,
                          appStartDate: "20220501")

    static let friendSaving1 =  Saving(goalProduct: Product.sampleData[1].productName,
                                goalWeeks: 18,
                                savingDayOfTheWeek: "화",
                                weekInfo: friendSavingList1,
                                appStartDate: "20220601")

    static let friendSaving2 =  Saving(goalProduct: Product.sampleData[2].productName,
                                goalWeeks: 23,
                                savingDayOfTheWeek: "수",
                                weekInfo: friendSavingList2,
                                appStartDate: "20220503")

    static let friendSaving3 = Saving(goalProduct: Product.sampleData[3].productName,
                               goalWeeks: 24,
                               savingDayOfTheWeek: "목",
                               weekInfo: friendSavingList3,
                               appStartDate: "20220517")

    static let my = User(id: "0", nickname: "Miller", creationDate: "", isAlarmOn: false, saveInfo: mySaving)
    static let friend1 = User(id: "1", nickname: "Max", creationDate: "", isAlarmOn: false, saveInfo: friendSaving1)
    static let friend2 = User(id: "2", nickname: "Bit", creationDate: "", isAlarmOn: false, saveInfo: friendSaving2)
    static let friend3 = User(id: "3", nickname: "Eve", creationDate: "", isAlarmOn: false, saveInfo: friendSaving3)
}
