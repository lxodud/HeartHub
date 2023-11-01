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
    
    init(
        navigationController: UINavigationController,
        finishDelegate: MyPageFinishDelegate
    ) {
        self.navigationController = navigationController
        self.finishDelegate = finishDelegate
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
        let profileModifyViewController = ProfileModifyViewController()
        navigationController.pushViewController(profileModifyViewController, animated: true)
    }
    
    func toWithdrawal() {
        let withdrawalViewController = WithdrawalViewController()
        navigationController.pushViewController(withdrawalViewController, animated: true)
    }
    
    func toChangePassword() {
        let passwordModifyViewController = PasswordModifyViewController()
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
