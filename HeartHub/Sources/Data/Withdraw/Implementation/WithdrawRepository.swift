//
//  WithdrawRepository.swift
//  HeartHub
//
//  Created by 이태영 on 2023/09/22.
//

import Foundation
import RxSwift

final class WithdrawRepository {
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
extension WithdrawRepository: WithdrawRepositoryType {
    func withdraw() -> Completable {
        let builder = MyPageRequestBuilderFactory.makeDeleteUserRequestBuilder()
        tokenProvider.deleteToken()
        myInformationRepository.removeMyInformation()
        
        return networkManager.request(builder)
            .ignoreElements()
            .asCompletable()
    }
}
