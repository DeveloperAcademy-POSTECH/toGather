//
//  MainViewModel.swift
//  ToGather
//
//  Created by DaeSeong on 2022/06/09.
//

import SwiftUI

class MainViewModel: ObservableObject {
   
   @Published private var friendsList = [FriendsProgressCircle]()
 
    func addFriend(friend : FriendsProgressCircle) {
        
        friendsList.append(friend)
    }
    
    func getFriendList() -> [FriendsProgressCircle] {
        return friendsList
    }
}
