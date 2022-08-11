//
//  FriendAdditionViewModel.swift
//  ToGather
//
//  Created by yudonlee on 2022/07/20.
//

import Foundation

final class FriendAdditionViewModel: ObservableObject {
    
    // MARK: - Properties
    @Published private var friendUids: [String] = []
    @Published private var friendNicknames: [String] = []
    
    // MARK: - Funcs
    func isFriendEmpty() -> Bool {
        if friendUids.isEmpty {
            return true
        }
        return false
    }
    
    func getFriendNicknames() -> [String]? {
        if friendNicknames.isEmpty {
            return nil
        }
        return friendNicknames
    }
    
    /// 친구의 Uid 얻어오기
    func getFriendUids() -> [String]? {
        if friendUids.isEmpty {
            return nil
        }
        return friendUids
    }
    
    private func appendList(uid: String, nickname: String) {
        
        if friendNicknames.firstIndex(of: nickname) != nil {
            return
        }
        friendUids.append(uid)
        friendNicknames.append(nickname)
    }
    
    func insertFriendUids(uid: String, completion: @escaping (Bool) -> Void) {
        FirebaseManager.shared.requestFriendNickname(friendUid: uid) { nickName in
            if let nickName = nickName {
                self.appendList(uid: uid, nickname: nickName)
                completion(true)
            } else {
                completion(false)
            }
        }
    }
    
    func removeFriendNickname(nickname: String) {
        guard let index = friendNicknames.firstIndex(of: nickname) else {
            return
        }
        if index < friendUids.count {
            friendUids.remove(at: index)
            friendNicknames.remove(at: index)
        }
    }

}
