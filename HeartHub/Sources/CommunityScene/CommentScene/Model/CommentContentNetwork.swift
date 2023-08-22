//
//  CommentContentNetwork.swift
//  HeartHub
//
//  Created by 이태영 on 2023/08/22.
//

import Foundation

final class CommentContentNetwork {
    private let tokenRepository: TokenRepository
    private let networkManager: NetworkManager
    
    private let tokenExpireResolver = TokenExpierResolver()
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
extension CommentContentNetwork {
    func fetchHeartStatus(
        with commentID: Int,
        completion: @escaping (Bool) -> Void
    ) {
        guard let accessToken = tokenRepository.fetchAccessToken() else {
            return
        }
        
        let request = CommunityRequestFactory.makeFetchCommentHeartStatusRequest(
            with: commentID,
            token: accessToken
        )
        
        networkManager.request(endpoint: request) { result in
            switch result {
            case .success(let data):
                guard let deserializedData: FetchButtonStatusResponseDTO = try? self.decode(from: data) else {
                    return
                }
                
                completion(deserializedData.data.status)
            case .failure(let error):
                print(#function)
                self.tokenExpireResolver.validateExpireAccessTokenError(error) {
                    self.postHeartComment(with: commentID)
                }
            }
        }
    }
    
    func postHeartComment(
        with commentID: Int
    ) {
        guard let accessToken = tokenRepository.fetchAccessToken() else {
            return
        }
        
        let request = CommunityRequestFactory.makeCommentLikeRequest(
            with: commentID,
            token: accessToken
        )
        
        networkManager.request(endpoint: request) { result in
            switch result {
            case .success(_):
                break
            case .failure(let error):
                print(#function)
                self.tokenExpireResolver.validateExpireAccessTokenError(error) {
                    self.postHeartComment(with: commentID)
                }
            }
        }
    }
    
    func deleteHeartComment(
        id: Int,
        username: String
    ) {
        guard let accessToken = tokenRepository.fetchAccessToken() else {
            return
        }
        
        let request = CommunityRequestFactory.makeCancleCommentLikeRequest(
            with: CancleCommentLikeRequestDTO(username: username, commentID: id),
            token: accessToken
        )
        
        networkManager.request(endpoint: request) { result in
            switch result {
            case .success(_):
                break
            case .failure(let error):
                print(#function)
                self.tokenExpireResolver.validateExpireAccessTokenError(error) {
                    self.deleteHeartComment(id: id, username: username)
                }
            }
            
        }
    }
}
