//
//  LoginService.swift
//  HeartHub
//
//  Created by 이태영 on 2023/08/19.
//

import RxSwift
import UIKit

final class LoginService {
    private let tokenRepository: TokenRepository
    private let networkManager: RxNetworkManager
    private let disposeBag = DisposeBag()
    
    init(
        tokenRepository: TokenRepository = TokenRepository(),
        networkManager: RxNetworkManager = DefaultRxNetworkManager()
    ) {
        self.tokenRepository = tokenRepository
        self.networkManager = networkManager
    }
}

// MARK: Public Interface
extension LoginService {
    func login(id: String, password: String) -> Observable<Void> {
        let builder = UserRelatedRequestBuilderFactory.makeSignInRequest(
            of: SignInRequestDTO(username: id, password: password)
        )
        
        return networkManager.request(builder)
            .do(onNext: {
                self.tokenRepository.saveToken(with: $0.data)
                self.saveCurrentUserInformation(username: id)
            })
            .map({ _ in  })
    }
    
    private func saveCurrentUserInformation(username: String) {
        let builder = UserRelatedRequestBuilderFactory.makeGetMyInformationRequest()
        let userInformationRepository = MyInformationRepository()
        userInformationRepository.saveUsername(with: username)
        
        networkManager.request(builder)
            .do(onNext: { userInformationRepository.saveNickname(with: $0.data.myNickname) })
            .compactMap({ URL(string: $0.data.myImageUrl) })
            .flatMap({
                RxImageProvider.shared.fetch(from: $0)
            })
            .subscribe(onNext: {
                userInformationRepository.saveProfileImage(with: $0)
            })
            .disposed(by: disposeBag)
    }
}
