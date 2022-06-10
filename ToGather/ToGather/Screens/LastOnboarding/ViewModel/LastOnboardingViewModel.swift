//
//  LastOnboardingViewModel.swift
//  ToGather
//
//  Created by Seungwon Choi on 2022/06/09.
//

import Foundation
import Firebase

class LastOnboardingViewModel: ObservableObject {
    func getData() {
        let db = Firestore.firestore()
        let user = db.collection("user").document("pCcyISPLupDk4i8hxAt2")
        user.getDocument { (document, error) in
            if let document = document, document.exists {
                let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                print("Document data: \(dataDescription)")
            } else {
                print("Document does not exist")
            }
        }
    }
}
