//
//  PasswordModifyViewModel.swift
//  HeartHub
//
//  Created by 이태영 on 2023/09/13.
//

import Foundation
import RxCocoa
import RxSwift

final class PasswordModifyViewModel: ViewModelType {
    struct Input {
        let currentPassword: Driver<String>
        let newPassword: Driver<String>
        let tapCurrentPasswodSecure: Driver<Void>
        let tapNewPasswodSecure: Driver<Void>
        let tapModify: Driver<Void>
    }
    
    struct Output {
        let canModify: Driver<Bool>
        let isCurrentPasswordSecure: Driver<Bool>
        let isNewPasswordSecure: Driver<Bool>
        let modifying: Driver<Bool>
        let modifyed: Driver<Bool>
    }
    
    private let accountUseCase: AccountUseCaseType
    
    init(accountUseCase: AccountUseCaseType = AccountUseCase()) {
        self.accountUseCase = accountUseCase
    }
}

// MARK: - Public Interface
extension PasswordModifyViewModel {
    func transform(_ input: Input) -> Output {
        let currentAndNewPassword = Driver.combineLatest(
            input.currentPassword,
            input.newPassword,
            resultSelector: {
                (current: $0, new: $1)
            })
        
        let isCurrentPasswordSecure = input.tapCurrentPasswodSecure
            .scan(true) { state, _ in
                return !state
            }
        
        let isNewPasswordSecure = input.tapNewPasswodSecure
            .scan(true) { state, _ in
                return !state
            }

        let modifyed = input.tapModify.withLatestFrom(currentAndNewPassword)
            .flatMap{ password in
                return self.accountUseCase.modifyPassword(
                    current: password.current,
                    new: password.new
                )
                .andThen(Observable.just(false))
                .asDriver(onErrorJustReturn: false)
            }
            
        let modifying = Observable.from([
            input.tapModify.map { _ in true },
            modifyed.map { _ in false }
        ])
            .merge()
            .distinctUntilChanged()
            .asDriver(onErrorJustReturn: false)
        
        let canModify = Observable.from([
            currentAndNewPassword.map { !$0.isEmpty && !$1.isEmpty },
            modifying.map { !$0 }
        ])
            .merge()
            .distinctUntilChanged()
            .asDriver(onErrorJustReturn: false)
        
        
        return Output(
            canModify: canModify,
            isCurrentPasswordSecure: isCurrentPasswordSecure,
            isNewPasswordSecure: isNewPasswordSecure,
            modifying: modifying,
            modifyed: modifyed
        )
    }
}
