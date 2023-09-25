//
//  AccountProfileInputViewModel.swift
//  HeartHub
//
//  Created by 이태영 on 2023/09/25.
//

import Foundation
import RxCocoa
import RxSwift

final class AccountProfileInputViewModel: ViewModelType {
    struct Input {
        let id: Driver<String>
        let password: Driver<String>
        let tapMale: Driver<Void>
        let tapFemale: Driver<Void>
        let birth: Observable<Date>
    }
    
    struct Output {
        let formattedBirth: Driver<String>
        let isMale: Driver<Bool>
        let isFemale: Driver<Bool>
    }
    
    private let accountUseCase: AccountUseCaseType
    
    init(
        accountUseCase: AccountUseCaseType
    ) {
        self.accountUseCase = accountUseCase
    }
}

// MARK: - Public Interface
extension AccountProfileInputViewModel {
    func transform(_ input: Input) -> Output {
        let formattedBirth = input.birth
            .map { SignUpDateFormatter.shared.string(from: $0) }
            .asDriver(onErrorJustReturn: "")
        
        let isMale = Driver.from([
            input.tapMale.map { _ in true },
            input.tapFemale.map { _ in false }
        ])
            .merge()
            .startWith(true)
            .distinctUntilChanged()
        
        let isFemale = Driver.from([
            input.tapMale.map { _ in false },
            input.tapFemale.map { _ in true }
        ])
            .merge()
            .startWith(false)
            .distinctUntilChanged()
        
        return Output(
            formattedBirth: formattedBirth,
            isMale: isMale,
            isFemale: isFemale
        )
    }
}
