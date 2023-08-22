//
//  CommentNetwork.swift
//  HeartHub
//
//  Created by 이태영 on 2023/08/22.
//

import Foundation

final class CommentNetwork {
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
extension CommentNetwork {
    func fetchComment(
        with articleID: Int,
        completion: @escaping ([Comment]) -> Void
    ) {
        guard let accessToken = tokenRepository.fetchAccessToken() else {
            return
        }
        
        let request = CommunityRequestFactory.makeFetchCommentRequest(
            with: articleID,
            token: accessToken
        )
        
        networkManager.request(endpoint: request) { result in
            switch result {
            case .success(let data):
                guard let deserializedData: FetchCommentResponseDTO = try? self.decode(from: data) else {
                    return
                }
                
                completion(deserializedData.data)
            case .failure(let error):
                self.tokenExpireResolver.validateExpireAccessTokenError(error) {
                    self.fetchComment(with: articleID, completion: completion)
                }
            }
        }
    }
    
    func postComment(
        username: String,
        articleID: Int,
        content: String,
        completion: @escaping () -> Void
    ) {
        guard let accessToken = tokenRepository.fetchAccessToken() else {
            return
        }
        
        let request = CommunityRequestFactory.makeRegisterCommentRequest(
            with: RegisterCommentRequestDTO(
                articleID: articleID,
                username: username,
                content: content,
                parentID: nil
            ),
            token: accessToken
        )
        
        networkManager.request(endpoint: request) { result in
            switch result {
            case .success(_):
                completion()
                break
            case .failure(let error):
                print(#function)
                self.tokenExpireResolver.validateExpireAccessTokenError(error) {
                    self.postComment(
                        username: username,
                        articleID: articleID,
                        content: content,
                        completion: completion
                    )
                }
            }
        }
    }
}
