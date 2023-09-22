//
//  WithdrawUseCase.swift
//  HeartHub
//
//  Created by 이태영 on 2023/09/22.
//

import Foundation
import RxSwift

final class WithdrawUseCase {
    private let accountRepository: AccountRepositoryType
    
    init(accountRepository: AccountRepositoryType = AccountRepository()) {
        self.accountRepository = accountRepository
    }
}

extension WithdrawUseCase: WithdrawUseCaseType {
    func withdraw() -> Completable {
        return accountRepository.withdraw()
    }
}
