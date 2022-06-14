//
//  LastOnboardingViewModel.swift
//  ToGather
//
//  Created by Seungwon Choi on 2022/06/13.
//

import Foundation
import Firebase

class LastOnboardingViewModel: ObservableObject {
    func changeDateFormat(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY.MM.dd"
        let dateToString: String = dateFormatter.string(from: date)
        
        return dateToString
    }

    func calculateDate(date: Date, goalWeeks: Int) -> String {
        let calendar = Calendar.current
        let addWeeksToCurrentDate: Date = calendar.date(byAdding: .weekOfYear, value: goalWeeks, to: date) ?? Date()
        let dateToString = changeDateFormat(date: addWeeksToCurrentDate)
        
        return dateToString
    }
}
