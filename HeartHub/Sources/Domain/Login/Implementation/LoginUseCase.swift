//
//  LoginUsecase.swift
//  HeartHub
//
//  Created by 이태영 on 2023/08/19.
//

import RxSwift
import UIKit

final class LoginUseCase {
    private let loginRepository: LoginRepositoryType
    
    init(
        loginRepository: LoginRepositoryType = LoginRepository()
    ) {
        self.loginRepository = loginRepository
    }
}

// MARK: Public Interface
extension LoginUseCase: LoginUseCaseType {
    func login(id: String, password: String) -> Observable<Bool> {
        return loginRepository.login(id: id, password: password)
    }
    
    func logout() -> Completable {
        return loginRepository.logout()
    }
}
