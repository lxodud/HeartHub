//
//  SignUpCoordinator.swift
//  HeartHub
//
//  Created by 이태영 on 2023/09/23.
//

import UIKit

final class SignUpCoordinator {
    private let navigationController: UINavigationController
    private let finishDelegate: SignUpFinishDelegate
    private let signUpUseCase = SignUpUseCase()
    private let alertTransitionDelegate = AlertTransitionDelegate()
    
    init(
        navigationController: UINavigationController,
        finishDelegate: SignUpFinishDelegate
    ) {
        self.navigationController = navigationController
        self.finishDelegate = finishDelegate
    }
}

// MARK: Public Interface
extension SignUpCoordinator: SignUpCoordinatable {
    func start() {
        toStartDateInput()
    }
    
    private func toStartDateInput() {
        let startDateInputViewController = StartDateInputViewController(
            viewModel: StartDateInputViewModel(
                coordinator: self,
                signUpUseCase: signUpUseCase
            )
        )
        
        navigationController.pushViewController(startDateInputViewController, animated: true)
    }
    
    func toAccountProfileInput() {
        let accountProfileInputViewController = AccountProfileInputViewController(
            viewModel: AccountProfileInputViewModel(
                coordinator: self,
                accountUseCase: AccountUseCase(),
                signUpUseCase: signUpUseCase
            )
        )
        
        navigationController.pushViewController(accountProfileInputViewController, animated: true)
    }
    
    func toNicknameEmailInput() {
        let nicknameEmailInputViewController = NicknameEmailInputViewController(
            viewModel: NicknameEmailInputViewModel(
                coordinator: self,
                myInformationUseCase: MyInformationUseCase(),
                accountUseCase: AccountUseCase(),
                authenticationUseCase: AuthenticationUseCase(),
                signUpUseCase: signUpUseCase
            )
        )
        
        navigationController.pushViewController(nicknameEmailInputViewController, animated: true)
    }
    
    func toTermAgree() {
        let termAgreeViewController = TermAgreeViewController(
            viewModel: TermAgreeViewModel(
                coordinator: self,
                accountUseCase: AccountUseCase(),
                signUpUseCase: signUpUseCase
            )
        )
        
        navigationController.pushViewController(termAgreeViewController, animated: true)
    }
    
    func toPersonalInformationCollectionAndUsageDetail() {
        let viewController = PersonalInformationCollectionAndUsageDetailViewController()
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func toTermOfUse() {
        let viewContriller = TermsOfUseViewController()
        navigationController.pushViewController(viewContriller, animated: true)
    }
    
    func showAlert(message: String, action: (() -> Void)?) {
        let alert = LoginAlertViewController(title: message, action: action)
        alert.transitioningDelegate = alertTransitionDelegate
        alert.modalPresentationStyle = .custom
        navigationController.present(alert, animated: true)
    }
    
    func toLogin() {
        finishDelegate.finish()
    }
}
