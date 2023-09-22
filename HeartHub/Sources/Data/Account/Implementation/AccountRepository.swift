//
//  AccountRepository.swift
//  HeartHub
//
//  Created by 이태영 on 2023/09/22.
//

import Foundation
import RxSwift

final class AccountRepository {
    private let myInformationRepository: MyInformationRepositoryType
    private let networkManager: NetworkManagerType
    private let tokenProvider: TokenProvidable
    
    init(
        myInformationRepository: MyInformationRepositoryType = MyInformationRepository(),
        networkManager: NetworkManagerType = NetworkManager(),
        tokenProvider: TokenProvidable = TokenProvider()
    ) {
        self.myInformationRepository = myInformationRepository
        self.networkManager = networkManager
        self.tokenProvider = tokenProvider
    }
}

// MARK: - Public Interface
extension AccountRepository: AccountRepositoryType {
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
    
    func withdraw() -> Completable {
        let builder = MyPageRequestBuilderFactory.makeDeleteUserRequestBuilder()
        tokenProvider.deleteToken()
        myInformationRepository.removeMyInformation()
        
        return networkManager.request(builder)
            .ignoreElements()
            .asCompletable()
    }
    
    func findId(with email: String) -> Observable<Bool> {
        let builder = UserRelatedRequestBuilderFactory.makeFindUsernameRequest(of: email)
        
        return networkManager.request(builder)
            .map({ $0.data })
    }
    
    func findPassword(id: String, email: String) -> Observable<Bool> {
        let requestBody = FindPasswordRequestDTO(id: id, email: email)
        let builder = UserRelatedRequestBuilderFactory.makeFindPasswordRequest(of: requestBody)
        
        return networkManager.request(builder)
            .map({ $0.data })
    }
}
