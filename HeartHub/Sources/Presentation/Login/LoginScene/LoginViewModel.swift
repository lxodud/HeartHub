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
        let logingIn: Driver<Bool>
        let loginSuccess: Driver<Void>
        let loginFail: Driver<Void>
    }
    
    private let coordinator: LoginCoordinatable
    private let authenticationUseCase: AuthenticationUseCaseType
    
    // MARK: - initializer
    init(
        coordinator: LoginCoordinatable,
        authenticationUseCase: AuthenticationUseCaseType = AuthenticationUseCase()
    ) {
        self.coordinator = coordinator
        self.authenticationUseCase = authenticationUseCase
    }
    
    func transform(_ input: Input) -> Output {
        let idAndPassword = Driver.combineLatest(
            input.id,
            input.password,
            resultSelector: {
                (id: $0, password: $1)
            })
        
        let toFindId = input.toFindIdTap
            .do { _ in self.coordinator.toFindId() }
        
        let toFindPassword = input.toFindPasswordTap
            .do { _ in self.coordinator.toFindPassword() }
        
        let toSignUp = input.toSignUpTap
            .do { _ in self.coordinator.toSignUp() }
        
        let loginTap = input.loginTap.withLatestFrom(idAndPassword)
    
        let logedIn = loginTap.flatMapLatest { pair in
            return self.authenticationUseCase.login(id: pair.id, password: pair.password)
                .asDriver(onErrorJustReturn: false)
        }
        
        let loginSuccess = logedIn.filter { $0 == true }
            .do { _ in
                // TODO: 탭바로 이동
            }
            .map { _ in }
        
        
        let loginFail = logedIn.filter({ $0 == false })
            .do { _ in self.coordinator.showAlert(message: "로그인 실패") }
            .map { _ in }
        
        
        let logingIn = Driver.from([
            loginTap.map { _ in true },
            logedIn.map { _ in false }
        ])
            .merge()
        
        let loginEnabled = Driver.from([
            idAndPassword.map { !$0.isEmpty && !$1.isEmpty },
            logingIn.map { !$0 }
        ])
            .merge()
        
        return Output(
            loginEnabled: loginEnabled,
            toFindId: toFindId,
            toFindPassword: toFindPassword,
            toSignUp: toSignUp,
            logingIn: logingIn,
            loginSuccess: loginSuccess,
            loginFail: loginFail
        )
    }
}
