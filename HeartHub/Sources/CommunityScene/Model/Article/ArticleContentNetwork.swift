//
//  ArticleContentNetwork.swift
//  HeartHub
//
//  Created by 이태영 on 2023/08/22.
//

import Foundation

final class ArticleContentNetwork {
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
extension ArticleContentNetwork {
    func postScrapOrCancelArticle(
        username: String,
        articleID: Int
    ) -> Cancellable? {
        guard let accessToken = tokenRepository.fetchAccessToken() else {
            return nil
        }
        
        guard let request = CommunityRequestFactory.makeScrapArticleRequest(
            with: ScrapArticleRequestDTO(username: username, articleID: articleID),
            token: accessToken
        ) else {
            return nil
        }
        
        let task = networkManager.request(endpoint: request) { result in
            switch result {
            case .success(_):
                break
            case .failure(let error):
                self.tokenExpierResolver.validateExpireAccessTokenError(error) {
                    self.postGoodArticle(username: username, articleID: articleID)
                }
            }
        }
        
        return task
    }
    
    @discardableResult
    func postGoodArticle(
        username: String,
        articleID: Int
    ) -> Cancellable? {
        guard let accessToken = tokenRepository.fetchAccessToken() else {
            return nil
        }
        
        let request = CommunityRequestFactory.makePostArticleGoodRequest(
            username: username,
            articleID: articleID,
            token: accessToken
        )
        
        let task = networkManager.request(endpoint: request) { result in
            switch result {
            case .success(_):
                break
            case .failure(let error):
                self.tokenExpierResolver.validateExpireAccessTokenError(error) {
                    self.postGoodArticle(username: username, articleID: articleID)
                }
            }
        }
        
        return task
    }
    
    @discardableResult
    func fetchGoodStatus(
        from articleId: Int,
        completion: @escaping (Bool) -> Void
    ) -> Cancellable? {
        guard let accessToken = tokenRepository.fetchAccessToken() else {
            return nil
        }
        
        let request = CommunityRequestFactory.makeFetchGoodStatusRequest(
            with: articleId,
            token: accessToken
        )
        
        let task = networkManager.request(endpoint: request) { result in
            switch result {
            case .success(let data):
                do {
                    guard let deserializedData: FetchButtonStatusResponseDTO = try self.decode(from: data) else {
                        return
                    }
                    
                    DispatchQueue.main.async {
                        completion(deserializedData.data.status)
                    }
                } catch {
                    print(error)
                }
                
            case .failure(let error):
                print(#function)
                self.tokenExpierResolver.validateExpireAccessTokenError(error) {
                    self.fetchGoodStatus(from: articleId, completion: completion)
                }
            }
        }
        
        return task
    }
    
    @discardableResult
    func fetchHeartStatus(
        from articleId: Int,
        completion: @escaping (Bool) -> Void
    ) -> Cancellable? {
        guard let accessToken = tokenRepository.fetchAccessToken() else {
            return nil
        }
        
        let request = CommunityRequestFactory.makeFetchHeartStatusRequest(
            with: articleId,
            token: accessToken
        )
        
        let task = networkManager.request(endpoint: request) { result in
            switch result {
            case .success(let data):
                guard let deserializedData: FetchButtonStatusResponseDTO = try? self.decode(from: data) else {
                    return
                }
                
                DispatchQueue.main.async {
                    completion(deserializedData.data.status)
                }
            case .failure(let error):
                print(#function)
                self.tokenExpierResolver.validateExpireAccessTokenError(error) {
                    self.fetchGoodStatus(from: articleId, completion: completion)
                }
            }
        }
        
        return task
    }
    
    @discardableResult
    func fetchGoodCount(
        from articleId: Int,
        completion: @escaping (Int) -> Void
    ) -> Cancellable? {
        guard let accessToken = tokenRepository.fetchAccessToken() else {
            return nil
        }
        
        let request = CommunityRequestFactory.makeFetchArticleLikeCountRequest(
            with: articleId,
            token: accessToken
        )
        
        let task = networkManager.request(endpoint: request) { result in
            switch result {
            case .success(let data):
                guard let deserializedData: FetchGoodCountResponseDTO = try? self.decode(from: data) else {
                    return
                }
                
                DispatchQueue.main.async {
                    completion(deserializedData.data)
                }
            case .failure(let error):
                print(#function)
                self.tokenExpierResolver.validateExpireAccessTokenError(error) {
                    self.fetchGoodCount(from: articleId, completion: completion)
                }
            }
        }
        
        return task
    }
}
