//
//  MainViewModel.swift
//  ToGather
//
//  Created by DaeSeong on 2022/06/09.
//

import SwiftUI

class MainViewModel: ObservableObject {
   
    @Published private var friendsList: [FriendProgressCircle] = [
        FriendProgressCircle(id: 1, user: dummyFriend1, color: RGBColorInProgressCircle.friendColor1),
        FriendProgressCircle(id: 2, user: dummyFriend2, color: RGBColorInProgressCircle.friendColor2)]
 
    func addFriend(friend : FriendProgressCircle) {
        friendsList.append(friend)
    }
    
    func getFriendList() -> [FriendProgressCircle] {
        
        return friendsList
    }
}
