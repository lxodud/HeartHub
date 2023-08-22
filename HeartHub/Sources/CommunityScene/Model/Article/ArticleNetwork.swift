//
//  CommunityNetwork.swift
//  HeartHub
//
//  Created by 이태영 on 2023/08/19.
//

import Foundation

final class ArticleNetwork {
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
extension ArticleNetwork {
    func fetchArticle(
        with theme: ArticleTheme,
        completion: @escaping ([Article]) -> Void
    ) {
        guard let accessToken = tokenRepository.fetchAccessToken() else {
            return
        }
        
        let request = CommunityRequestFactory.makeFetchCommunityArticleRequest(
            with: theme,
            token: accessToken
        )
        
        networkManager.request(endpoint: request) { result in
            switch result {
            case .success(let data):
                do {
                    let deserializedData: FetchArticleResponseDTO = try self.decode(from: data)
                    
                    DispatchQueue.main.async {
                        completion(deserializedData.data)
                    }
                } catch {
                    print(error)
                }
                
                
            case .failure(let error):
                self.tokenExpireResolver.validateExpireAccessTokenError(error) {
                    self.fetchArticle(with: theme, completion: completion)
                }
                break
            }
        }
    }
    
    func postArticle(
        username: String,
        imageData: [Data],
        content: String,
        theme: ArticleTheme,
        completion: @escaping (Article) -> Void
    ) {
        guard let accessToken = tokenRepository.fetchAccessToken() else {
            return
        }
        
        guard let request = CommunityRequestFactory.makePostArticleRequest(
            articleContent: PostArticleRequestDTO(content: content, theme: theme, userName: username),
            imageData: imageData,
            token: accessToken
        ) else {
            return
        }
        
        networkManager.request(endpoint: request) { result in
            switch result {
            case .success(let data):
                guard let deserializedData: PostArticleResponseDTO = try? self.decode(from: data),
                      let id = Int(deserializedData.data)
                else {
                    return
                }
                
                self.fetchArticleDetail(with: id) { article in
                    completion(article)
                }
                
            case .failure(let error):
                self.tokenExpireResolver.validateExpireAccessTokenError(error) {
                    self.postArticle(
                        username: username,
                        imageData: imageData,
                        content: content,
                        theme: theme,
                        completion: completion
                    )
                }
            }
        }
    }
}

// MARK: - Private Method
extension ArticleNetwork {
    private func fetchArticleDetail(with articleID: Int, completion: @escaping (Article) -> Void) {
        guard let accessToken = tokenRepository.fetchAccessToken() else {
            return
        }
        
        let request = CommunityRequestFactory.makeFetchCommunityArticleDetailRequest(
            with: articleID,
            token: accessToken
        )
        
        networkManager.request(endpoint: request) { result in
            switch result {
            case .success(let data):
                guard let deserializedData: FetchArticleDetailDTO = try? self.decode(from: data) else {
                    return
                }
                
                completion(deserializedData.data)
            case .failure(let error):
                self.tokenExpireResolver.validateExpireAccessTokenError(error) {
                    self.fetchArticleDetail(with: articleID, completion: completion)
                }
            }
        }
    }
}
