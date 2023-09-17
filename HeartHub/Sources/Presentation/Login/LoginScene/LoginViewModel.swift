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
    }
    
    private weak var coordinator: LoginCoordinatable?
    
    init(coordinator: LoginCoordinatable) {
        self.coordinator = coordinator
    }
    
    func transform(_ input: Input) -> Output {
        let idAndPassword = Driver.combineLatest(
            input.id,
            input.password,
            resultSelector: {
                ($0, $1)
            })
        
        let loginEnabled = idAndPassword
            .map({ !$0.isEmpty && !$1.isEmpty })
            .distinctUntilChanged()
            .asDriver()
        
        let findId = input.findIdTap
            .do(onNext: {
                self.coordinator?.toFindID()
            })
        
        let findPassword = input.findPasswordTap
            .do(onNext: {
                self.coordinator?.toFindPassword()
            })
        
        let signUp = input.signUpTap
            .do(onNext: {
                self.coordinator?.toSignUp()
            })
        
        return Output(
            loginEnabled: loginEnabled,
            findId: findId,
            findPassword: findPassword,
            signUp: signUp
        )
    }
}
