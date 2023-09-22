//
//  FIndIdViewModel.swift
//  HeartHub
//
//  Created by 이태영 on 2023/09/18.
//

import RxCocoa
import RxSwift

final class FindIdViewModel: ViewModelType {
    struct Input {
        let email: Driver<String>
        let toLoginTap: Driver<Void>
        let toFindPasswordTap: Driver<Void>
        let toSignUpTap: Driver<Void>
        let findIdTap: Driver<Void>
    }
    
    struct Output {
        let findIdEnabled: Driver<Bool>
        let toLogin: Driver<Void>
        let toFindPassword: Driver<Void>
        let toSignUp: Driver<Void>
        let searchingId: Driver<Bool>
        let foundId: Driver<Bool>
    }
    
    private weak var coordinator: LoginCoordinatable?
    private let accountUseCase: AccountUseCaseType
    
    // MARK: - initializer
    init(
        coordinator: LoginCoordinatable?,
        accountUseCase: AccountUseCaseType = AccountUseCase()
    ) {
        self.coordinator = coordinator
        self.accountUseCase = accountUseCase
    }
    
    func transform(_ input: Input) -> Output {
        let toLogin = input.toLoginTap
            .do { _ in self.coordinator?.toLogin() }
        
        let toFindPassword = input.toFindPasswordTap
            .do { _ in self.coordinator?.toFindPassword() }
        
        let toSignUp = input.toSignUpTap
            .do { _ in self.coordinator?.toSignUp() }
        
        let foundId = input.findIdTap.withLatestFrom(input.email)
            .flatMap({ email in
                return self.accountUseCase.findId(with: email)
                    .asDriver(onErrorJustReturn: false)
            })
            .do { _ in self.coordinator?.showAlert(message: "하잇") }
        
        let searchingId = Observable.from([
            input.findIdTap.map({ _ in true }),
            foundId.map({ _ in false })
        ])
            .merge()
            .distinctUntilChanged()
            .asDriver(onErrorJustReturn: false)
        
        let findIdEnabled = Observable.from([
            input.email.map({ !$0.isEmpty }),
            searchingId.map({ !$0 })
        ])
            .merge()
            .distinctUntilChanged()
            .asDriver(onErrorJustReturn: false)
        
        
        return Output(
            findIdEnabled: findIdEnabled,
            toLogin: toLogin,
            toFindPassword: toFindPassword,
            toSignUp: toSignUp,
            searchingId: searchingId,
            foundId: foundId
        )
    }
}
