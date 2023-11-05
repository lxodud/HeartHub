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
    
    private lazy var backButton = UIBarButtonItem(
        image: UIImage(systemName: "chevron.left"),
        style: .plain,
        target: self,
        action: #selector(didTapBackButton)
    )
    
    init(
        navigationController: UINavigationController,
        finishDelegate: SignUpFinishDelegate
    ) {
        self.navigationController = navigationController
        self.finishDelegate = finishDelegate
        backButton.tintColor = .black
    }
    
    @objc private func didTapBackButton() {
        navigationController.popViewController(animated: true)
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
        
        startDateInputViewController.navigationItem.leftBarButtonItem = backButton
        
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
        
        accountProfileInputViewController.navigationItem.leftBarButtonItem = backButton
        
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
        
        nicknameEmailInputViewController.navigationItem.leftBarButtonItem = backButton
        
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
        
        termAgreeViewController.navigationItem.leftBarButtonItem = backButton
        
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
        let alert = CancelOnlyAlertViewController(title: message, action: action)
        alert.transitioningDelegate = alertTransitionDelegate
        alert.modalPresentationStyle = .custom
        navigationController.present(alert, animated: true)
    }
    
    func toLogin() {
        finishDelegate.finish()
    }
}
