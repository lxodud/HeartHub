//
//  MyPageCoordinator.swift
//  HeartHub
//
//  Created by 이태영 on 2023/11/01.
//

import UIKit

final class MyPageCoordinator {
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
}

extension MyPageCoordinator: MyPageCoordinatable {
    func start() {
        let myPageMainViewController = MyPageMainViewController(
            viewModel: MyPageMainViewModel()
        )
        
        navigationController.viewControllers = [myPageMainViewController]
    }
}
