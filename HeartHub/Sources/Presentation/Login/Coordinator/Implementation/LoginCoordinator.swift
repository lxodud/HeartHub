//
//  LoginCoordinator.swift
//  HeartHub
//
//  Created by 이태영 on 2023/09/15.
//

import UIKit

final class LoginCoordinator {
    private let window: UIWindow

    init(window: UIWindow) {
        self.window = window
    }
}

// MARK: - Public Interface
extension LoginCoordinator: LoginCoordinatable {
    func start() {
        let loginViewController = LoginViewController(
            loginViewModel: LoginViewModel(coordinator: self)
        )
        window.rootViewController = loginViewController
    }
    
    func toFindID() {
        let findIdViewController = FindIdViewController()
        window.rootViewController = findIdViewController
        UIView.transition(
            with: window,
            duration: 0.5,
            options: [.transitionCrossDissolve],
            animations: nil,
            completion: nil
        )
    }
    
    func toFindPassword() {
        let findPwViewController = FindPwViewController()
        window.rootViewController = findPwViewController
        UIView.transition(
            with: window,
            duration: 0.5,
            options: [.transitionCrossDissolve],
            animations: nil,
            completion: nil
        )
    }
    
    func toSignUp() {
        // TODO: - SignUpCoordinator 구현
        print(#function)
    }
}
