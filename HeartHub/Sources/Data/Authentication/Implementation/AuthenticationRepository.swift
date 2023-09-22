//
//  AuthenticationRepository.swift
//  HeartHub
//
//  Created by 이태영 on 2023/09/20.
//

import Foundation
import RxSwift

final class AuthenticationRepository {
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

extension AuthenticationRepository: AuthenticationRepositoryType {
    func login(id: String, password: String) -> Observable<Bool> {
        let loginInfo = LoginRequestDTO(id: id, password: password)
        let builder = UserRelatedRequestBuilderFactory.makeLoginRequest(of: loginInfo)
        
        return networkManager.request(builder)
            .map { Token(accessToken: $0.data.accessToken, refreshToken: $0.data.refreshToken)}
            .do { self.tokenProvider.saveToken(with: $0) }
            .map { _ in true }
    }
    
    func logout() -> Completable {
        let builder = UserRelatedRequestBuilderFactory.makeLogoutRequest()
        return networkManager.request(builder)
            .ignoreElements()
            .asCompletable()
    }
}
