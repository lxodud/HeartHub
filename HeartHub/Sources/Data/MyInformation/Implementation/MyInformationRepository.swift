//
//  MyInformationRepository.swift
//  HeartHub
//
//  Created by 이태영 on 2023/08/21.
//

import Foundation
import RxSwift

struct UserInformation {
    let profileImage: Data
    let nickname: String
}

final class MyInformationRepository: MyInformationRepositoryType {
    private let informationProvider: UserDefaults
    private let networkManager: NetworkManagerType
    private let tokenProvider: TokenProvidable
    
    init(
        informationProvider: UserDefaults = UserDefaults.standard,
        networkManager: NetworkManagerType = NetworkManager(),
        tokenProvider: TokenProvidable = TokenProvider() 
    ) {
        self.informationProvider = informationProvider
        self.networkManager = networkManager
        self.tokenProvider = tokenProvider
    }
}

// MARK: Public Interface
extension MyInformationRepository {
    @discardableResult
    func upsertUserInformation(with userInformation: UserInformation) -> Completable {
        let image = userInformation.profileImage
        let nickname = userInformation.nickname
        
        self.informationProvider.set(image, forKey: "profileImage")
        self.informationProvider.set(nickname, forKey: "nickname")
        
        guard let builder = try? MyPageRequestBuilderFactory.makeModifyProfileRequestBuilder(
            imageData: image,
            nickname: nickname
        ) else {
            return Completable.error(NetworkError.decodingError)
        }
        
        return networkManager.request(builder)
            .ignoreElements()
            .asCompletable()
    }
    
    func fetchUserInformation() -> Observable<UserInformation> {
        guard let profileImage = informationProvider.data(forKey: "profileImage"),
              let nickname = informationProvider.string(forKey: "nickname")
        else {
            return fetchMyInformationFromNetworking()
        }
        
        return Observable.create { emitter in
            emitter.onNext(UserInformation(profileImage: profileImage, nickname: nickname))
            
            return Disposables.create()
        }
    }
    
    private func fetchMyInformationFromNetworking() -> Observable<UserInformation> {
        let builder = UserRelatedRequestBuilderFactory.makeGetMyInformationRequest()
        var username: String = ""
        
        return networkManager.request(builder)
            .do { username = $0.data.myNickname }
            .compactMap { URL(string: $0.data.myImageUrl) }
            .flatMap { ImageProvider.shared.fetch(from: $0) }
            .map { UserInformation(profileImage: $0, nickname: username) }
            .do { self.upsertUserInformation(with: $0) }
    }
    
    func removeMyInformation() {
        informationProvider.removeObject(forKey: "profileImage")
        informationProvider.removeObject(forKey: "nickname")
    }
}
