//
//  TimeLogic.swift
//  ToGather
//
//  Created by hyo on 2022/06/15.
//

import SwiftUI
import Combine

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

/// 20220602 -> 2022.06.02
func dateFormatter(date: String) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "YYYYMMdd"
    formatter.locale = Locale(identifier: "ko_KR")
    
    let date = formatter.date(from: date) ?? Date()
    formatter.dateFormat = "YYYY.MM.dd"
    return formatter.string(from: date)
}

/// 오늘 날짜 구하기 ~월 ~일 형식 ex) 7월 31일
func getToday(date: Date = Date()) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "MMM dd일"
    formatter.locale = Locale(identifier: "ko_KR")
    return formatter.string(from: Date())
}

/// 요일 구하기 ex) 월, 화, 수, 목...
func getDay(date: Date = Date()) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "E"
    formatter.locale = Locale(identifier: "ko_KR")
    return formatter.string(from: date)
}

/// 저축 요일을 정한 후 appStartDate기반으로 첫번째 저축 날짜 구하기
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
func getCurrentWeek(from firstSavingDate: String, weekInfo: [ThisWeek]) -> Int {
    let firstSavingDate: Date = stringToDate(date: firstSavingDate)
    
    let now = Date()

    let dateGap = Calendar.current.dateComponents([.day], from: firstSavingDate, to: now)
    
    // 오류 처리 필요
    let dateGapDay = dateGap.day ?? 0
    var currentWeek: Int = (dateGapDay <= 0 ? 1 : (dateGapDay / 8 + 2) )
    if dateGapDay % 7 == 0 && weekInfo[currentWeek - 1].didSave == true {
        currentWeek += 1
    }
    
    return currentWeek
}

/// 저축 종료 날짜를 구하기
/// totalweek는 goalWeek + 추가Week(false의 개수)
func getLastSavingDate(firstSavingDate: String, totalWeek: Int) -> String {
    let firstSavingDate = stringToDate(date: firstSavingDate)
    
    let lastSavingDate = Calendar.current.date(byAdding: .weekOfYear, value: totalWeek - 1, to: firstSavingDate) ?? Date()
    return dateToString(date: lastSavingDate)
}

func getCurrentWeekEndDate(currentWeek: Int, firstSavingDate: String) -> Date {
    let firstSavingDate: Date = stringToDate(date: firstSavingDate)
    let currentWeekEndDate = Calendar.current.date(byAdding: .day, value: (currentWeek - 1) * 7 + 1, to: firstSavingDate) ?? Date()
    return currentWeekEndDate
}

func isSavingDay(currentWeekEndDate: Date) -> Bool {
    let now = Date()
    
    let dateGap = Calendar.current.dateComponents([.day], from: now, to: currentWeekEndDate)
    
    return dateGap.day! == 0 ? true : false
}

/// 저축 데드라인 구하기. firstSavingDate, 현재 주차기반으로 계산
func getRemainTime(from currentWeekEndDate: Date) -> String {
    let now = Date()
    
    let dateGap = Calendar.current.dateComponents([.day, .hour, .minute, .second], from: now, to: currentWeekEndDate)
    
    // TODO: 초 제거 필요.디버깅용
    if case let (d?, h?, m?, s?) = (dateGap.day, dateGap.hour, dateGap.minute, dateGap.second) {
        return "\(d)일 \(h)시간 \(m)분 \(s)초"
    }
    return "error"
}

struct TimeLogicTest: View {
    @State var remaindDate: String = getRemainTime(from : getCurrentWeekEndDate(currentWeek: getCurrentWeek(from: "20220615", weekInfo: [ThisWeek(presentWeek: 1, didSave: true)]), firstSavingDate: "20220623"))
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    let setDay = DummyData.my.saveInfo.savingDayOfTheWeek //월
    let goalWeek = DummyData.my.saveInfo.goalWeeks // 25
    let appStartDay = "20220601"
    
    // 현재날짜로부터 + 7 일 이상될 수가 없음
    let firstSavingDate: String = "20220617"
    
    var body: some View {
        VStack {
            Text(remaindDate).onReceive(timer) { _ in
                self.remaindDate =  getRemainTime(from : getCurrentWeekEndDate(currentWeek: getCurrentWeek(from: "20220615", weekInfo: [ThisWeek(presentWeek: 1, didSave: true)]), firstSavingDate: "20220623"))
            }
            Text("\(getLastSavingDate(firstSavingDate: "20220601",totalWeek: 1))")
        }
    }
}

struct TimeLogicTest_Previews: PreviewProvider {
    static var previews: some View {
        TimeLogicTest()
    }
}
