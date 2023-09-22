//
//  WithdrawUseCase.swift
//  HeartHub
//
//  Created by 이태영 on 2023/09/22.
//

import Foundation
import RxSwift

final class WithdrawUseCase {
    private let withdrawRepository: WithdrawRepositoryType
    
    init(withdrawRepository: WithdrawRepositoryType = WithdrawRepository()) {
        self.withdrawRepository = withdrawRepository
    }
}

extension WithdrawUseCase: WithdrawUseCaseType {
    func withdraw() -> Completable {
        return withdrawRepository.withdraw()
    }
}
