//
//  MainViewModel.swift
//  ToGather
//
//  Created by DaeSeong on 2022/06/09.
//

import SwiftUI

class MainViewModel: ObservableObject {
   
//    @Published private var friendsList = [FriendsProgressCircle]()
    
    
    
    @Published private var friendsList: [FriendsProgressCircle] = [
        FriendsProgressCircle(id: 1, user: dummyFriend1, color: RGBColorInProgressCircle.friendColor1),
        FriendsProgressCircle(id: 2, user: dummyFriend2, color: RGBColorInProgressCircle.friendColor2)]
 
    func addFriend(friend : FriendsProgressCircle) {
        friendsList.append(friend)
    }
    
    func getFriendList() -> [FriendsProgressCircle] {
        
        return friendsList
    }
}
