//
//  ConnectCoordinator.swift
//  HeartHub
//
//  Created by 이태영 on 2023/11/05.
//

import UIKit

final class ConnectCoordinator: ConnectCoordinatable {
    private let navigationController: UINavigationController
    private let alertTransitionDelegate = AlertTransitionDelegate()
    
    private lazy var backButton = UIBarButtonItem(
        image: UIImage(systemName: "chevron.left"),
        style: .plain,
        target: self,
        action: #selector(didTapBackButton)
    )
    
    // MARK: - initializer
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    @objc private func didTapBackButton() {
        navigationController.popViewController(animated: true)
    }
}

// MARK: Public Interface
extension ConnectCoordinator {
    func start() {
        let connectViewController = ConnectViewController(
            viewModel: ConnectViewModel(coordinator: self)
        )
        connectViewController.navigationItem.leftBarButtonItem = backButton
        
        navigationController.pushViewController(connectViewController, animated: true)
    }
    
    func toMateInformation(_ id: String) {
        let connectCheckPopUpViewController = ConnectCheckAlertViewController(
            viewModel: ConnectCheckViewModel(id: id, coordinator: self)
        )
        connectCheckPopUpViewController.transitioningDelegate = alertTransitionDelegate
        connectCheckPopUpViewController.modalPresentationStyle = .custom
        navigationController.present(connectCheckPopUpViewController, animated: true)
    }
    
    func toSuccessAlert() {
        let alert = UIAlertController(
            title: "매칭 완료되었습니다.",
            message: nil,
            preferredStyle: .alert
        )
        
        let action = UIAlertAction(title: "확인", style: .default) { _ in
            self.navigationController.popToRootViewController(animated: true)
        }
        
        alert.addAction(action)
        
        navigationController.dismiss(animated: true) {
            self.navigationController.present(alert, animated: true)
        }
    }
}
