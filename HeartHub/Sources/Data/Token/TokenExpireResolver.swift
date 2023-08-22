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
            
            let deserializedData: RequestFailResponseDTO? = try? self.decode(from: data)
            
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
        
        let request = UserRelatedRequestFactory.makeReissueTokenRequest(token: refreshToken)
        
        self.networkManager.request(endpoint: request) { result in
            switch result {
            case .success(let data):
                guard let deserializedData: FetchReissueTokenResponseDTO = try? self.decode(from: data)
                else {
                    return
                }
                
                let accessToken = deserializedData.data.newAccessToken
                let refreshToken = deserializedData.data.newRefreshToken
                let token = Token(accessToken: accessToken, refreshToken: refreshToken)
                
                self.tokenRepository.saveToken(with: token)
                completion()
                
            case .failure(let error):
                if case NetworkError.requestFail(_, let data) = error {
                    print(error.localizedDescription)
                }
            }
            
        }
    }
}
