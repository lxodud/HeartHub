//
//  MyPageCoordinator.swift
//  HeartHub
//
//  Created by 이태영 on 2023/11/01.
//

import UIKit

final class MyPageCoordinator {
    private let navigationController: UINavigationController
    private let finishDelegate: MyPageFinishDelegate
    private let alertTransitionDelegate = AlertTransitionDelegate()
    
    private lazy var backButton = UIBarButtonItem(
        image: UIImage(systemName: "chevron.left"),
        style: .plain,
        target: self,
        action: #selector(didTapBackButton)
    )
    
    init(
        navigationController: UINavigationController,
        finishDelegate: MyPageFinishDelegate
    ) {
        self.navigationController = navigationController
        self.finishDelegate = finishDelegate
        self.backButton.tintColor = .black
    }
    
    @objc private func didTapBackButton() {
        navigationController.popViewController(animated: true)
    }
}

extension MyPageCoordinator: MyPageCoordinatable {    
    func start() {
        let myPageMainViewController = MyPageMainViewController(
            viewModel: MyPageMainViewModel(
                coordinator: self
            )
        )
        
        navigationController.viewControllers = [myPageMainViewController]
    }
    
    func toEditProfile() {
        let profileModifyViewController = ProfileModifyViewController(
            viewModel: ProfileModifyViewModel(
                myInformationUseCase: MyInformationUseCase()
            )
        )
        
        profileModifyViewController.navigationItem.leftBarButtonItem = backButton
        navigationController.pushViewController(profileModifyViewController, animated: true)
    }
    
    func toWithdrawal() {
        let withdrawalViewController = WithdrawalViewController(
            viewModel: WithdrawalViewModel(
                accountUseCase: AccountUseCase()
            )
        )
        
        withdrawalViewController.navigationItem.leftBarButtonItem = backButton
        navigationController.pushViewController(withdrawalViewController, animated: true)
    }
    
    func toChangePassword() {
        let passwordModifyViewController = PasswordModifyViewController(
            viewModel: PasswordModifyViewModel(
                accountUseCase: AccountUseCase()
            )
        )
        
        passwordModifyViewController.navigationItem.leftBarButtonItem = backButton
        navigationController.pushViewController(passwordModifyViewController, animated: true)
    }
    
    func showAlert(message: String, action: (() -> Void)?) {
        let alert = ConfirmAndCancelAlertViewController(title: message, action: action)
        alert.transitioningDelegate = alertTransitionDelegate
        alert.modalPresentationStyle = .custom
        navigationController.present(alert, animated: true)
    }
    
    func toLogin() {
        finishDelegate.finish()
    }
}
