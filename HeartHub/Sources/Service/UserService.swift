//
//  UserService.swift
//  HeartHub
//
//  Created by 이태영 on 2023/08/22.
//

import Foundation

final class UserService {
    private let tokenRepository: TokenRepository
    private let networkManager: NetworkManager
    private let tokenExpierResolver = TokenExpierResolver()
    
    init(
        tokenRepository: TokenRepository,
        networkManager: NetworkManager
    ) {
        self.tokenRepository = tokenRepository
        self.networkManager = networkManager
    }
}

// MARK: - Public Interface
extension UserService {
    @discardableResult
    func fetchAuthorInformation(
        from userId: Int,
        completion: @escaping (String?) -> Void
    ) -> Cancellable? {
        guard let accessToken = tokenRepository.fetchAccessToken() else {
            return nil
        }
        
        let builder = UserRelatedRequestFactory.makeGetUserInformation(
            of: userId,
            token: accessToken
        )
        
        let task = networkManager.request(builder) { result in
            switch result {
            case .success(let data):
                let imageUrl = data.data.userImageUrl
                completion(imageUrl)
            case .failure(let error):
                print(#function)
//                self.tokenExpierResolver.validateExpireAccessTokenError(error) {
//                    self.fetchAuthorInformation(from: userId, completion: completion)
//                }
            }
        }
        
        return task
    }
}
