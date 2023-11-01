//
//  CoupleSpaceCoordinator.swift
//  HeartHub
//
//  Created by 이태영 on 2023/10/30.
//

import UIKit

final class CoupleSpaceCoordinator {
    private let navigationController: UINavigationController
    
    // MARK: - initializer
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
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
        
    }
    
    func toMission() {
        
    }
    
    func toConnect() {
        
    }
}
