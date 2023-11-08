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
    func fetchMateInformation() -> RxSwift.Observable<UserInformation> {
        let builder = UserRelatedRequestBuilderFactory.makeGetUserInformation(of: 10)
        var username: String = ""
        
        return networkManager.request(builder)
            .do { username = $0.data.nickname }
            .compactMap { URL(string: $0.data.userImageUrl) }
            .flatMap { ImageProvider.shared.fetch(from: $0) }
            .map { UserInformation(profileImage: $0, nickname: username) }
    }
    
    func checkMateExist() -> Observable<Bool> {
        let builder = UserRelatedRequestBuilderFactory.makeCheckMateExistRequest()
        
        return networkManager.request(builder)
            .map { $0.hasMate }
    }
}

