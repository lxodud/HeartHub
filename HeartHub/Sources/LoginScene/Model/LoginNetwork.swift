//
//  LoginNetwork.swift
//  HeartHub
//
//  Created by 이태영 on 2023/08/19.
//

import UIKit

final class LoginNetwork {
    private let tokenRepository: TokenRepository
    private let networkManager: NetworkManager
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

// MARK: Public Interface
extension LoginNetwork {
    func login(id: String, password: String, completion: @escaping () -> Void) {
        let builder = UserRelatedRequestFactory.makeSignInRequest(
            of: SignInRequestDTO(username: id, password: password)
        )
        
        networkManager.request(builder) { result in
            switch result {
            case .success(let data):
                let token = data.data
                self.tokenRepository.saveToken(with: token)
                self.saveCurrentUserInformation(token: token.accessToken, username: id)
                completion()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func saveCurrentUserInformation(token: String, username: String) {
        let builder = UserRelatedRequestFactory.makeGetMyInformationRequest(token: token)
        let userInformationRepository = UserInformationRepository()
        userInformationRepository.saveUsername(with: username)
        
        networkManager.request(builder) { result in
            switch result {
            case .success(let data):
                let info = data.data
                let nickname = info.myNickname
                userInformationRepository.saveNickname(with: nickname)
                
                guard let imageUrl = URL(string: info.myImageUrl) else {
                    return
                }
                
                ImageProvider.shared.fetch(from: imageUrl) { result in
                    switch result {
                    case .success(let data):
                        userInformationRepository.saveProfileImage(with: data)
                    case .failure(let error):
                        print(error)
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
