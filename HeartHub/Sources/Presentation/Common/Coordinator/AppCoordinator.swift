//
//  AppCoordinator.swift
//  HeartHub
//
//  Created by 이태영 on 2023/09/14.
//

import UIKit

final class AppCoordinator {
    private let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
}

// MARK: - Public Interface
extension AppCoordinator: Coordinatable {
    func start() {
        TokenProvider().deleteToken()
        if TokenProvider().fetchAccessToken() == nil {
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
        loginCoordinator.start()
    }
    
    private func showTabBar() {
        
    }
}
