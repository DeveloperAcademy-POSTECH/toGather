//
//  LastOnboardingViewModel.swift
//  ToGather
//
//  Created by Seungwon Choi on 2022/06/13.
//

import Foundation
import Firebase

class LastOnboardingViewModel: ObservableObject {
    @Published var nicknameArray: [String] = []
    
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
    
    // user 컬렉션에서 friend의 uid로 검색하여 친구 닉네임 가져오기
    func fetchFriendNickname(friendUids: [String]) {
        let db = Firestore.firestore()
        
        for friendUid in friendUids {
            let docRef = db.collection("user").document(friendUid)
            
            docRef.getDocument { (document, error) in
                if let document = document, document.exists {
                    let nickName: String = document.get("nickName") as? String ?? friendUid
                    self.nicknameArray.append(nickName)
                } else {
                    print("User document does not exist (failed to get freind's nickname)")
                }
            }
        }
    }
}
