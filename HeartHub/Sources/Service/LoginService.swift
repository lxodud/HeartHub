//
//  LoginService.swift
//  HeartHub
//
//  Created by 이태영 on 2023/08/19.
//

import UIKit

final class LoginService {
    private let tokenRepository: TokenRepository
    private let networkManager: NetworkManager
    
    init(
        tokenRepository: TokenRepository = TokenRepository(),
        networkManager: NetworkManager = DefaultNetworkManager()
    ) {
        self.tokenRepository = tokenRepository
        self.networkManager = networkManager
    }
}

// MARK: Public Interface
extension LoginService {
    func login(id: String, password: String, completion: @escaping () -> Void) {
        let builder = UserRelatedRequestBuilderFactory.makeSignInRequest(
            of: SignInRequestDTO(username: id, password: password)
        )
        
        networkManager.request(builder) { result in
            switch result {
            case .success(let data):
                let token = data.data
                self.tokenRepository.saveToken(with: token)
                self.saveCurrentUserInformation(username: id)
                completion()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func saveCurrentUserInformation(username: String) {
        let builder = UserRelatedRequestBuilderFactory.makeGetMyInformationRequest()
        let userInformationRepository = MyInformationRepository()
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
