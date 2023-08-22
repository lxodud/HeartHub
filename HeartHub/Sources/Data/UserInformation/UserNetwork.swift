//
//  UserNetwork.swift
//  HeartHub
//
//  Created by 이태영 on 2023/08/22.
//

import Foundation

final class UserNetwork {
    private let tokenRepository: TokenRepository
    private let networkManager: NetworkManager
    private let tokenExpierResolver = TokenExpierResolver()
    private let decoder = JSONDecoder()
    
    init(
        tokenRepository: TokenRepository,
        networkManager: NetworkManager
    ) {
        self.tokenRepository = tokenRepository
        self.networkManager = networkManager
    }
    
    private func decode<T: Decodable>(from data: Data) throws -> T {
        return try decoder.decode(T.self, from: data)
    }
}

// MARK: - Public Interface
extension UserNetwork {
    @discardableResult
    func fetchAuthorInformation(
        from userId: Int,
        completion: @escaping (String?) -> Void
    ) -> Cancellable? {
        guard let accessToken = tokenRepository.fetchAccessToken() else {
            return nil
        }
        
        let request = UserRelatedRequestFactory.makeGetUserInformation(
            of: userId,
            token: accessToken
        )
        
        let task = networkManager.request(endpoint: request) { result in
            switch result {
            case .success(let data):
                guard let deserializedData: GetUserInformationResponseDTO = try? self.decode(from: data),
                      let imageUrl = deserializedData.data.userImageUrl
                else {
                    completion(nil)
                    return
                }
                
                completion(imageUrl)
            case .failure(let error):
                print(#function)
                self.tokenExpierResolver.validateExpireAccessTokenError(error) {
                    self.fetchAuthorInformation(from: userId, completion: completion)
                }
            }
        }
        
        return task
    }
}
