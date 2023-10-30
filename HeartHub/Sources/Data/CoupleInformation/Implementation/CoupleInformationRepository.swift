//
//  CoupleInformationRepository.swift
//  HeartHub
//
//  Created by 이태영 on 2023/10/30.
//

import RxSwift

final class CoupleInformationRepository {
    private let networkManager: NetworkManagerType
    
    init(networkManager: NetworkManagerType = NetworkManager()) {
        self.networkManager = networkManager
    }
}

// MARK: - Public Interface
extension CoupleInformationRepository: CoupleInformationRepositoryType {
    func checkMateExist() -> Observable<Bool> {
        let builder = UserRelatedRequestBuilderFactory.makeCheckMateExistRequest()
        
        return networkManager.request(builder)
            .map { $0.hasMate }
    }
}

