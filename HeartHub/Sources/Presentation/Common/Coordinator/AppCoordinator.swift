//
//  AppCoordinator.swift
//  HeartHub
//
//  Created by 이태영 on 2023/09/14.
//

import UIKit

final class AppCoordinator {
    private let window: UIWindow
    private var childCoordinators: [Coordinatable] = []
    
    init(window: UIWindow) {
        self.window = window
    }
}

// MARK: - Public Interface
extension AppCoordinator: Coordinatable {
    func start() {
        TokenRepository().deleteToken()
        if TokenRepository().fetchAccessToken() == nil {
            showLogin()
        } else {
            showTabBar()
        }
    }
}

// MARK: - Private Method
extension AppCoordinator {
    private func showLogin() {
        let loginCoordinator = LoginCoordinator(window: window)
        childCoordinators.append(loginCoordinator)
        loginCoordinator.start()
    }
    
    private func showTabBar() {
        
    }
}
