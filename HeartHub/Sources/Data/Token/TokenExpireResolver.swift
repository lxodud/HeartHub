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
    
    func validateExpireAccessTokenError(_ error: Error, completion: @escaping () -> Void) {
        if case NetworkError.requestFail(_, let data) = error {
            guard let data = data else {
                return
            }
            
            let deserializedData: BasicResponseDTO? = try? self.decode(from: data)
            
            if deserializedData?.code == 3000 {
                self.resolveExpireAccessToken {
                    completion()
                }
            } else {
                print(error.localizedDescription)
            }
        } else {
            print(error.localizedDescription)
        }
    }
    
    private func resolveExpireAccessToken(completion: @escaping () -> Void) {
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
                if case NetworkError.requestFail(_, let data) = error {
                    print(error.localizedDescription)
                }
            }
            
        }
    }
}
