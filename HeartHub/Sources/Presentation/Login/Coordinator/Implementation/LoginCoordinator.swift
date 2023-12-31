//
//  LoginCoordinator.swift
//  HeartHub
//
//  Created by 이태영 on 2023/09/15.
//

import UIKit

final class LoginCoordinator {
    private let window: UIWindow
    private var finishDelegate: CoordinatorFinishDelegate
    private let navigationController = UINavigationController()
    private let alertTransitionDelegate = AlertTransitionDelegate()

    init(
        window: UIWindow,
        finishDelegate: CoordinatorFinishDelegate
    ) {
        self.window = window
        self.finishDelegate = finishDelegate
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
        
        navigationController.viewControllers = [loginViewController]
        window.rootViewController = navigationController
        
        UIView.transition(
            with: window,
            duration: 0.5,
            options: [.transitionCrossDissolve],
            animations: nil,
            completion: nil
        )
    }
    
    func toFindId() {
        let findIdViewController = FindIdViewController(
            findIdViewModel: FindIdViewModel(coordinator: self)
        )
        navigationController.viewControllers = [findIdViewController]
        window.rootViewController = navigationController
        
        UIView.transition(
            with: window,
            duration: 0.5,
            options: [.transitionCrossDissolve],
            animations: nil,
            completion: nil
        )
    }
    
    func toFindPassword() {
        let findPasswordViewController = FindPasswordViewController(
            viewModel: FindPasswordViewModel(coordinator: self)
        )
        
        navigationController.viewControllers = [findPasswordViewController]
        window.rootViewController = navigationController
        
        UIView.transition(
            with: window,
            duration: 0.5,
            options: [.transitionCrossDissolve],
            animations: nil,
            completion: nil
        )
    }
    
    func toSignUp() {
        let signUpCoordinator = SignUpCoordinator(
            navigationController: navigationController,
            finishDelegate: self
        )
        signUpCoordinator.start()
    }
    
    func showAlert(message: String) {
        let alert = CancelOnlyAlertViewController(title: message)
        alert.transitioningDelegate = alertTransitionDelegate
        alert.modalPresentationStyle = .custom
        window.rootViewController?.present(alert, animated: true)
    }
    
    func toMain() {
        finishDelegate.finish(coordinator: self)
    }
}

// MARK: SignUpFinishDelegate Implementation
extension LoginCoordinator: SignUpFinishDelegate {
    func finish() {
        toLogin()
    }
}
