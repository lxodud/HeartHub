//
//  AccountUseCase.swift
//  HeartHub
//
//  Created by 이태영 on 2023/09/22.
//

import Foundation
import RxSwift

final class AccountUseCase {
    private let accountRepository: AccountRepositoryType
    
    init(accountRepository: AccountRepositoryType = AccountRepository()) {
        self.accountRepository = accountRepository
    }
}

// MARK: - Public Interface
extension AccountUseCase: AccountUseCaseType {
    func modifyPassword(current: String, new: String ) -> Completable {
        return accountRepository.modifyPassword(current: current, new: new)
    }
}
