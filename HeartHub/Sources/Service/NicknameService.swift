//
//  NicknameService.swift
//  HeartHub
//
//  Created by 이태영 on 2023/09/10.
//

import Foundation

final class NicknameService {
    private let networkManager: NetworkManager
    
    init(networkManager: NetworkManager = DefaultNetworkManager()) {
        self.networkManager = networkManager
    }
}

// MARK: - Public Interface
extension NicknameService {
    func checkNicknameAvailability(with nickname: String, completion: @escaping (Bool) -> Void) {
        let builder = UserRelatedRequestBuilderFactory.makeNicknameCheckRequest(of: nickname)
        
        networkManager.request(builder) { result in
            switch result {
            case .success(let data):
                completion(data.data)
            case .failure(let error):
                print(error)
            }
        }
    }
}
