//
//  MyInformationRepository.swift
//  HeartHub
//
//  Created by 이태영 on 2023/08/21.
//

import Foundation

final class MyInformationRepository {
    private let store = UserDefaults.standard
}

// MARK: Public Interface
extension MyInformationRepository {
    func saveProfileImage(with imageData: Data) {
        store.set(imageData, forKey: "profileImage")
    }
    
    func saveNickname(with nickname: String) {
        store.set(nickname, forKey: "nickname")
    }
    
    func saveUsername(with username: String) {
        store.set(username, forKey: "username")
    }
    
    func fetchProfileImage() -> Data? {
        return store.data(forKey: "profileImage")
    }
    
    func fetchNickname() -> String? {
        return store.string(forKey: "nickname")
    }
    
    func fetchUsername() -> String? {
        return store.string(forKey: "username")
    }
    
    func removeAllInformation() {
        store.removeObject(forKey: "profileImage")
        store.removeObject(forKey: "nickname")
        store.removeObject(forKey: "username")
    }
}
