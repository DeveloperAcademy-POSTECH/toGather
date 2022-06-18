//
//  TimeLogic.swift
//  ToGather
//
//  Created by hyo on 2022/06/15.
//

import SwiftUI
import Combine

let setDay = dummyMy.saveInfo.savingDayOfTheWeek //월
let goalWeek = dummyMy.saveInfo.goalWeeks // 25
let appStartDay = "20220601"

//goalWeeks: 25,
//startDate: "20220603",
//savingDayOfTheWeek: "월",

// 현재날짜로부터 + 7 일 이상될 수가 없음
let firstSavingDate: String = "20220617"

func dateToString(date: Date) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "YYYYMMdd"
    formatter.locale = Locale(identifier: "ko_KR")
    return formatter.string(from: date)
}

func stringToDate(date: String) -> Date {
    let formatter = DateFormatter()
    formatter.dateFormat = "YYYYMMdd"
    formatter.locale = Locale(identifier: "ko_KR")
    return formatter.date(from: date) ?? Date()
}

/// 요일 구하기
func getDay(date: Date = Date()) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "E"
    formatter.locale = Locale(identifier: "ko_KR")
    return formatter.string(from: date)
}

/// 저축 요일을 정한 후 첫번째 저축 날짜 구하기
func getFirstSavingDate(setDay: String, appStartDate: String) -> String {
    let dayOfWeek = ["월" : 0, "화" : 1, "수" : 2, "목" : 3, "금" : 4, "토" : 5, "일" : 6]
    let firstSavingDate: Date
    
    let startDate: Date = stringToDate(date: appStartDate)
    
    if let setDay = dayOfWeek[setDay],
       let nowDay = dayOfWeek[getDay(date: startDate)] {
        var addDay = setDay - nowDay
        addDay = (addDay < 0) ? addDay + 7 : addDay

        // 현재 날짜에서 addDay를 더하기
        firstSavingDate = Date(timeInterval: TimeInterval(addDay * 60 * 60 * 24) , since: startDate)
        return dateToString(date: firstSavingDate)
    }
    return "error"
}

/// 현재 주차 구하기, firstSavingDate, 현재시간 기반으로 계산
func getCurrentWeek(from firstSavingDate: String) -> Int {
    let firstSavingDate: Date = stringToDate(date: firstSavingDate)
    
    let now = Date()
    
    // to에서 from 을 빼는 형식
    // now : 0615
    // from : 0607 < 3 차이 8
    // from : 0608 < 2
    // from : 0609 < 2
    // from : 0610 < 2
    // from : 0611 < 2
    // from : 0612 < 2
    // from : 0613 < 2
    // from : 0614 < 2 차이 1
    // from : 0615 < 1 차이 0
    // from : 0616 < 1 차이 -1
    // from : 0617 < 1 차이 -2
    
    let dateGap = Calendar.current.dateComponents([.day], from: firstSavingDate, to: now)
    
    // 오류 처리 필요
    let dateGapDay = dateGap.day ?? 0
    
    let currentWeek: Int = dateGapDay <= 0 ? 1 : ((dateGapDay) / 7 + 2)
   
    return currentWeek
}

/// 저축 종료 날짜를 구하기
/// totalweek는 goalWeek + 추가Week(false의 개수)
func getLastSavingDate(firstSavingDate: String, totalWeek: Int) -> String {
    let firstSavingDate = stringToDate(date: firstSavingDate)
    
    let lastSavingDate = Calendar.current.date(byAdding: .weekOfYear, value: totalWeek, to: firstSavingDate) ?? Date()
    return dateToString(date: lastSavingDate)
}

/// 저축 데드라인 구하기. firstSavingDate, 현재 주차기반으로 계산
func getRemainTime(firstSavingDate: String) -> String {
    let curretWeek: Int = getCurrentWeek(from: firstSavingDate)
    let firstSavingDate: Date = stringToDate(date: firstSavingDate)
    let deadLine = Calendar.current.date(byAdding: .day, value: (curretWeek - 1) * 7 + 1, to: firstSavingDate) ?? Date()
    let now = Date()
    let dateGap = Calendar.current.dateComponents([.day, .hour, .minute, .second], from: now, to: deadLine)
    
    // TODO: 초 제거 필요.디버깅용
    if case let (d?, h?, m?, s?) = (dateGap.day, dateGap.hour, dateGap.minute, dateGap.second) {
        return "\(d)일 \(h)시간 \(m)분 \(s)초"
    }
    return "error"
}

//struct TimeLogicTest: View {
//
//    @State var remaindDate: String = getRemainTime(firstSavingDate: "20220615")
//    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
//
//    var body: some View {
//        VStack {
//            Text(remaindDate).onReceive(timer) {_ in
//                self.remaindDate = getRemainTime(firstSavingDate: "20220615") }
//            Text("\(getLastSavingDate(firstSavingDate: "20220601",totalWeek: 1))")
//        }
//    }
//}

struct TimeLogicTest: View {

    @State var remaindDate: String = getRemainTime(firstSavingDate: "20220615")
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    var body: some View {
        VStack {
            Text(remaindDate).onReceive(timer) {_ in
                self.remaindDate = getRemainTime(firstSavingDate: "20220615") }
            Text("\(getLastSavingDate(firstSavingDate: "20220601",totalWeek: 1))")
        }
    }
}


struct TimeLogicTest_Previews: PreviewProvider {
    static var previews: some View {
        TimeLogicTest()
    }
}

