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
//        TokenProvider().deleteToken()
//        if TokenProvider().fetchAccessToken() == nil {
            showLogin()
//        } else {
//            showMain()
//        }
    }
}

// MARK: - Private Method
extension AppCoordinator {
    private func showLogin() {
        let loginCoordinator = LoginCoordinator(
            window: window,
            finishDelegate: self
        )
        childCoordinators.append(loginCoordinator)
        loginCoordinator.start()
    }
    
    private func showMain() {
        let tapBarCoordinator = TabBarCoordinator(
            window: window,
            finishDelegate: self
        )
        childCoordinators.append(tapBarCoordinator)
        tapBarCoordinator.start()
    }
}

// MARK: - CoordinatorFinishDelegate Implementation
extension AppCoordinator: CoordinatorFinishDelegate {
    func finish(coordinator: Coordinatable?) {
        childCoordinators = childCoordinators.filter { $0 !== coordinator }
        switch coordinator {
        case is LoginCoordinatable:
            showMain()
        case is TabBarCoordinator:
            showLogin()
        default:
            break
        }
    }
}
