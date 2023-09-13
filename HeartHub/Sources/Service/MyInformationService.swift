//
//  MyInformationService.swift
//  HeartHub
//
//  Created by 이태영 on 2023/09/10.
//

import Foundation

final class MyInformationService {
    private let myInformationRepository: MyInformationRepository
    private let tokenRepository: TokenRepository
    private let networkManager: NetworkManager
    
    init(
        myInformationRepository: MyInformationRepository = MyInformationRepository(),
        tokenRepository: TokenRepository = TokenRepository(),
        networkManager: NetworkManager = DefaultNetworkManager()
    ) {
        self.myInformationRepository = myInformationRepository
        self.tokenRepository = tokenRepository
        self.networkManager = networkManager
    }
}

// MARK: Public Interface
extension MyInformationService {
    func fetchProfileImage() -> Data? {
        return myInformationRepository.fetchProfileImage()
    }
    
    func fetchNickname() -> String? {
        return myInformationRepository.fetchNickname()
    }
    
    func fetchUsername() -> String? {
        return myInformationRepository.fetchUsername()
    }
    
    func removeMyInformation() {
        myInformationRepository.removeAllInformation()
    }
    
    func editMyInformation(
        imageData: Data,
        nickname: String,
        completion: @escaping (Result<Void, Error>) -> Void
    ) {
        do {
            let builder = try MyPageRequestBuilderFactory.makeModifyProfileRequestBuilder(
                imageData: imageData,
                nickname: nickname
            )
            
            networkManager.request(builder) { result in
                switch result {
                case .success(_):
                    completion(.success(()))
                    self.myInformationRepository.saveProfileImage(with: imageData)
                    self.myInformationRepository.saveNickname(with: nickname)
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        } catch {
            completion(.failure(error))
        }
    }
    
    func withdraw(completion: @escaping (Bool) -> Void) {
        let builder = MyPageRequestBuilderFactory.makeDeleteUserRequestBuilder()
        
        networkManager.request(builder) { result in
            switch result {
            case .success(let data):
                self.myInformationRepository.removeAllInformation()
                self.tokenRepository.deleteToken()
                completion(data.data)
            case .failure(_):
                completion(false)
            }
        }
    }
    
    func modifyPassword(
        current: String,
        new: String,
        completion: @escaping (Bool) -> Void
    ) {
        guard let token = tokenRepository.fetchAccessToken() else {
            return
        }
        let body = ChangePasswordRequestDTO(
            token: token,
            currentPassword: current,
            changePassword: new
        
        )
        
        let builder = UserRelatedRequestBuilderFactory.makeChangePasswordRequest(of: body)
        
        networkManager.request(builder) { result in
            switch result {
            case .success(let data):
                completion(true)
            case .failure(let error):
                completion(false)
            }
        }
    }
}
