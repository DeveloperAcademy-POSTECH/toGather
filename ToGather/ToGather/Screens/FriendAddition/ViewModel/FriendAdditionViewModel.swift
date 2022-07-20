//
//  FriendAdditionViewModel.swift
//  ToGather
//
//  Created by yudonlee on 2022/07/20.
//

import Foundation

final class FriendAdditionViewModel: ObservableObject {
    @Published private var friendUids: [String] = []
    @Published private var friendNickname: [String] = []
    
    func isFriendEmpty() -> Bool {
        if friendUids.isEmpty {
            return true
        }
        return false
    }
    func getFriendNickname() -> [String]? {
        if friendNickname.isEmpty {
            return nil
        }
        return friendNickname
    }
    
    func getFriendUids() -> [String]? {
        if friendUids.isEmpty {
            return nil
        }
        return friendUids
    }
    
    private func appendList(uid: String, nickname: String) {
        
        if let _ = friendNickname.firstIndex(of: nickname) {
            return
        }
        friendUids.append(uid)
        friendNickname.append(nickname)
    }
    
    func insertFriendUids(uid: String) -> Bool {
        var isFriendExist: Bool = true
        
        FirebaseManager.shared.isFriendUidExist(friendUid: uid) { nickName in
            if let nickName = nickName {
                self.appendList(uid: uid, nickname: nickName)
                isFriendExist = true
            } else {
                isFriendExist = false
            }
        }
        return isFriendExist
    }
    
    func removeFriendNickname(nickname: String) {
        guard let index = friendNickname.firstIndex(of: nickname) else {
            return
        }
        if index < friendUids.count {
            friendUids.remove(at: index)
            friendNickname.remove(at: index)
        }
    }
}
