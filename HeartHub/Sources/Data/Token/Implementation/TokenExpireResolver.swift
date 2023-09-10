//
//  TokenExpireResolver.swift
//  HeartHub
//
//  Created by 이태영 on 2023/08/22.
//

import Foundation

final class TokenExpierResolver {
    private let decoder = JSONDecoder()
    private let tokenRepository = TokenRepository()
    private let networkManager = DefaultNetworkManager()
    
    private func decode<T: Decodable>(from data: Data) throws -> T {
        return try decoder.decode(T.self, from: data)
    }
    
    func resolveExpireAccessToken(completion: @escaping () -> Void) {
        guard let refreshToken = tokenRepository.fetchRefreshToken() else {
            return
        }
        
        let builder = UserRelatedRequestFactory.makeReissueTokenRequest(token: refreshToken)
        
        self.networkManager.request(builder) { result in
            switch result {
            case .success(let data):
                let token = data.data
                
                let accessToken = token.newAccessToken
                let refreshToken = token.newRefreshToken
                let newToken = Token(accessToken: accessToken, refreshToken: refreshToken)
                
                self.tokenRepository.saveToken(with: newToken)
                completion()
                
            case .failure(let error):
                print(error.localizedDescription)
            }
            
        }
    }
}
