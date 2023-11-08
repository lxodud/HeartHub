//
//  CoupleSpaceCoordinator.swift
//  HeartHub
//
//  Created by 이태영 on 2023/10/30.
//

import UIKit

final class CoupleSpaceCoordinator {
    private let navigationController: UINavigationController
    
    private lazy var backButton = UIBarButtonItem(
        image: UIImage(systemName: "chevron.left"),
        style: .plain,
        target: self,
        action: #selector(didTapBackButton)
    )
    
    // MARK: - initializer
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        backButton.tintColor = .black
    }
    
    @objc private func didTapBackButton() {
        navigationController.popViewController(animated: true)
    }
}

// MARK: - Public Interface
extension CoupleSpaceCoordinator: CoupleSpaceCoordinatable {
    func start() {
        let coupleSpaceMainViewController = CoupleSpaceMainViewController(
            viewModel: CoupleSpaceMainViewModel(
                coordinator: self
            )
        )
        
        navigationController.viewControllers = [coupleSpaceMainViewController]
    }
    
    func toAlbum() {
        let coupleSpaceAlbumViewController = CoupleSpaceAlbumViewController()
        coupleSpaceAlbumViewController.navigationItem.leftBarButtonItem = backButton
        
        navigationController.pushViewController(coupleSpaceAlbumViewController, animated: true)
    }
    
    func toConnect() {
        let coordinator = ConnectCoordinator(navigationController: navigationController)
        coordinator.start()
    }
}
