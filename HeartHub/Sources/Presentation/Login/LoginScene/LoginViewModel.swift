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
        let findIdTap: Driver<Void>
        let findPasswordTap: Driver<Void>
        let signUpTap: Driver<Void>
    }
    
    struct Output {
        let loginEnabled: Driver<Bool>
        let findId: Driver<Void>
        let findPassword: Driver<Void>
        let signUp: Driver<Void>
        let loginIn: Driver<Bool>
        let logedIn: Driver<Bool>
    }
    
    private weak var coordinator: LoginCoordinatable?
    private let loginService: LoginService
    
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
        
        let findId = input.findIdTap
            .do(onNext: { _ in self.coordinator?.toFindID() })
        
        let findPassword = input.findPasswordTap
            .do(onNext: { _ in self.coordinator?.toFindPassword() })
        
        let signUp = input.signUpTap
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
            findId: findId,
            findPassword: findPassword,
            signUp: signUp,
            loginIn: logingIn,
            logedIn: logedIn
        )
    }
}
