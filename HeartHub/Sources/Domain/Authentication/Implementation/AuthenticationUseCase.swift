//
//  AuthenticationUseCase.swift
//  HeartHub
//
//  Created by 이태영 on 2023/08/19.
//

import RxSwift
import UIKit

final class AuthenticationUseCase {
    private let authenticationRepository: AuthenticationRepositoryType
    
    init(
        authenticationRepository: AuthenticationRepositoryType = AuthenticationRepository()
    ) {
        self.authenticationRepository = authenticationRepository
    }
}

// MARK: Public Interface
extension AuthenticationUseCase: AuthenticationUseCaseType {
    func login(id: String, password: String) -> Observable<Bool> {
        return authenticationRepository.login(id: id, password: password)
    }
    
    func logout() -> Completable {
        return authenticationRepository.logout()
    }
    
    func sendVerificationCode(to email: String) -> Observable<Bool> {
        return authenticationRepository.sendVerificationCode(to: email)
    }
    
    func checkVerificationCode(with code: String) -> Bool {
        authenticationRepository.checkVerificationCode(with: code)
    }
}
