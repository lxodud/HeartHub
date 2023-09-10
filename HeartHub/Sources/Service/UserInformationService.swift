//
//  UserInformationService.swift
//  HeartHub
//
//  Created by 이태영 on 2023/08/22.
//

import Foundation

final class UserInformationService {
    private let networkManager: NetworkManager
    
    init(
        networkManager: NetworkManager
    ) {
        self.networkManager = networkManager
    }
}

// MARK: - Public Interface
extension UserInformationService {
    @discardableResult
    func fetchAuthorInformation(
        from userId: Int,
        completion: @escaping (String?) -> Void
    ) -> Cancellable? {
        let builder = UserRelatedRequestBuilderFactory.makeGetUserInformation(
            of: userId
        )
        
        let task = networkManager.request(builder) { result in
            switch result {
            case .success(let data):
                let imageUrl = data.data.userImageUrl
                completion(imageUrl)
            case .failure(_):
                break
            }
        }
        
        return task
    }
}
