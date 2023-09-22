//
//  LoginCoordinator.swift
//  HeartHub
//
//  Created by 이태영 on 2023/09/15.
//

import UIKit

final class LoginCoordinator {
    private let window: UIWindow
    private let alertTransitionDelegate = AlertTransitionDelegate()

    init(window: UIWindow) {
        self.window = window
    }
}

// MARK: - Public Interface
extension LoginCoordinator: LoginCoordinatable {
    func start() {
        toLogin()
    }
    
    func toLogin() {
        let loginViewController = LoginViewController(
            loginViewModel: LoginViewModel(coordinator: self)
        )
        window.rootViewController = loginViewController
        UIView.transition(
            with: window,
            duration: 0.5,
            options: [.transitionCrossDissolve],
            animations: nil,
            completion: nil
        )
    }
    
    func toFindID() {
        let findIdViewController = FindIdViewController(
            findIdViewModel: FindIdViewModel(coordinator: self)
        )
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
    
    func showAlert(message: String) {
        let alert = LoginAlertViewController(title: message)
        alert.transitioningDelegate = alertTransitionDelegate
        alert.modalPresentationStyle = .custom
        window.rootViewController?.present(alert, animated: true)
    }
}
