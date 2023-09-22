//
//  PasswordRepository.swift
//  HeartHub
//
//  Created by 이태영 on 2023/09/22.
//

import Foundation
import RxSwift

final class PasswordRepository {
    private let networkManager: NetworkManagerType
    private let tokenProvider: TokenProvidable
    
    init(
        networkManager: NetworkManagerType = NetworkManager(),
        tokenProvider: TokenProvidable = TokenProvider()
    ) {
        self.networkManager = networkManager
        self.tokenProvider = tokenProvider
    }
}

// MARK: - Public Interface
extension PasswordRepository: PasswordRepositoryType {
    func modifyPassword(current: String, new: String) -> Completable {
        guard let token = tokenProvider.fetchAccessToken() else {
            return Completable.error(NetworkError.decodingError)
        }
        
        let body = ChangePasswordRequestDTO(
            token: token,
            currentPassword: current,
            changePassword: new
        )
        
        let builder = UserRelatedRequestBuilderFactory.makeChangePasswordRequest(of: body)
        
        return networkManager.request(builder)
            .ignoreElements()
            .asCompletable()
    }
}
