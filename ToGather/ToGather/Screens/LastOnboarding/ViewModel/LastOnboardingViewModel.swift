//
//  LastOnboardingViewModel.swift
//  ToGather
//
//  Created by Seungwon Choi on 2022/06/09.
//

import Foundation
import Firebase

class LastOnboardingViewModel: ObservableObject {
    @Published var savingInfo = [Saving]()
    
    func getData() {
        let db = Firestore.firestore()
    }
}
