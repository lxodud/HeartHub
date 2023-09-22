//
//  FindPasswordViewModel.swift
//  HeartHub
//
//  Created by 이태영 on 2023/09/22.
//

import Foundation
import RxSwift
import RxCocoa

final class FindPasswordViewModel: ViewModelType {
    struct Input {
        let id: Driver<String>
        let email: Driver<String>
        let findPasswordTap: Driver<Void>
        let toFindIdTap: Driver<Void>
        let toLoginTap: Driver<Void>
        let toSignUpTap: Driver<Void>
    }
    
    struct Output {
        let findPasswordEnabled: Driver<Bool>
        let toFindId: Driver<Void>
        let toLogin: Driver<Void>
        let toSignUp: Driver<Void>
        let searchingPassword: Driver<Bool>
        let foundPassword: Driver<Void>
    }
    
    private weak var coordinator: LoginCoordinatable?
    private let accountUseCase: AccountUseCaseType
    
    init(
        coordinator: LoginCoordinatable,
        accountUseCase: AccountUseCaseType = AccountUseCase()
    ) {
        self.coordinator = coordinator
        self.accountUseCase = accountUseCase
    }
    
    func transform(_ input: Input) -> Output {
        let idAndEmail = Driver.combineLatest(
            input.id,
            input.email,
            resultSelector: {
                (id: $0, email: $1)
            })
        
        let toFindId = input.toFindIdTap
            .do { _ in self.coordinator?.toFindId() }
            
        let toLogin = input.toLoginTap
            .do { _ in self.coordinator?.toLogin() }
        
        let toSignUp = input.toSignUpTap
            .do { _ in self.coordinator?.toSignUp() }
        
        let foundPassword = input.findPasswordTap.withLatestFrom(idAndEmail)
            .flatMap {
                return self.accountUseCase.findPassword(id: $0.id, email: $0.email)
                    .asDriver(onErrorJustReturn: false)
            }
            .map { isSuccess in
                isSuccess == true ? "메일로 임시 비밀번호가 전송되었습니다." : "사용자 정보를 찾을 수 없습니다."
            }
            .do { self.coordinator?.showAlert(message: $0) }
            .map { _ in }
        
        let searchingPassword = Driver.from([
            input.findPasswordTap.map { _ in true },
            foundPassword.map { _ in false }
        ])
            .merge()
            .distinctUntilChanged()
        
        let findPasswordEnabled = Driver.from([
            idAndEmail.map { !$0.id.isEmpty && !$0.email.isEmpty },
            searchingPassword.map { !$0 }
        ])
            .merge()
            .distinctUntilChanged()
        
        return Output(
            findPasswordEnabled: findPasswordEnabled,
            toFindId: toFindId,
            toLogin: toLogin,
            toSignUp: toSignUp,
            searchingPassword: searchingPassword,
            foundPassword: foundPassword
        )
    }
}
