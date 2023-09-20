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
    }
    
    struct Output {
        let findIdEnabled: Driver<Bool>
        let toLogin: Driver<Void>
        let toFindPassword: Driver<Void>
        let toSignUp: Driver<Void>
    }
    
    private weak var coordinator: LoginCoordinator?
    
    // MARK: - initializer
    init(coordinator: LoginCoordinator?) {
        self.coordinator = coordinator
    }
    
    func transform(_ input: Input) -> Output {
        let findIdEnabled = input.email
            .map({ !$0.isEmpty })
            .distinctUntilChanged()
            .asDriver()
        
        let toLogin = input.toLoginTap
            .do(onNext: { _ in self.coordinator?.toLogin()})
        
        let toFindPassword = input.toFindPasswordTap
            .do(onNext: { _ in self.coordinator?.toFindPassword()})
        
        let toSignUp = input.toSignUpTap
            .do(onNext: { _ in self.coordinator?.toSignUp()})

        return Output(
            findIdEnabled: findIdEnabled,
            toLogin: toLogin,
            toFindPassword: toFindPassword,
            toSignUp: toSignUp
        )
    }
}
