//
//  LoginViewModel.swift
//  HeartHub
//
//  Created by 이태영 on 2023/09/17.
//

import RxCocoa
import RxSwift

final class LoginViewModel: ViewModelType {
    struct Input {
        let id: Driver<String>
        let password: Driver<String>
        let loginTap: Driver<Void>
        let toFindIdTap: Driver<Void>
        let toFindPasswordTap: Driver<Void>
        let toSignUpTap: Driver<Void>
    }
    
    struct Output {
        let loginEnabled: Driver<Bool>
        let toFindId: Driver<Void>
        let toFindPassword: Driver<Void>
        let toSignUp: Driver<Void>
        let loginIn: Driver<Bool>
        let logedIn: Driver<Bool>
    }
    
    private weak var coordinator: LoginCoordinatable?
    private let loginService: LoginService
    
    // MARK: - initializer
    init(coordinator: LoginCoordinatable, loginService: LoginService = LoginService()) {
        self.coordinator = coordinator
        self.loginService = loginService
    }
    
    func transform(_ input: Input) -> Output {
        let idAndPassword = Driver.combineLatest(
            input.id,
            input.password,
            resultSelector: {
                (id: $0, password: $1)
            })
        
        let loginEnabled = idAndPassword
            .map({ !$0.isEmpty && !$1.isEmpty })
            .distinctUntilChanged()
        
        let toFindId = input.toFindIdTap
            .do(onNext: { _ in self.coordinator?.toFindID() })
        
        let toFindPassword = input.toFindPasswordTap
            .do(onNext: { _ in self.coordinator?.toFindPassword() })
        
        let toSignUp = input.toSignUpTap
            .do(onNext: { _ in self.coordinator?.toSignUp() })
        
        let loginTap = input.loginTap.withLatestFrom(idAndPassword)
        
        let logedIn = loginTap.flatMapLatest({ pair in
                return self.loginService.login(id: pair.id, password: pair.password)
                    .asDriver(onErrorJustReturn: false)
            })
            .do(onNext: { _ in self.coordinator?.toSignUp() })
        
        let logingIn = Observable.from([
            loginTap.map { _ in true },
            logedIn.map { _ in false }
        ])
        .merge()
        .asDriver(onErrorJustReturn: false)
        
        return Output(
            loginEnabled: loginEnabled,
            toFindId: toFindId,
            toFindPassword: toFindPassword,
            toSignUp: toSignUp,
            loginIn: logingIn,
            logedIn: logedIn
        )
    }
}
