//
//  TabBarCoordinator.swift
//  HeartHub
//
//  Created by 이태영 on 2023/08/04.
//

import UIKit

final class TabBarCoordinator: TabBarCoordinatable {
    private let window: UIWindow
    private let tabBarController = UITabBarController()
    private let coupleSpaceNavigationViewController = UINavigationController()
    private let myPageNavigationViewController = UINavigationController()
    
    // MARK: - initializer
    init(window: UIWindow) {
        self.window = window
        configureTabBarItems()
        configureTabBarViewControllers()
        configureChildCoordinator()
    }

    private func configureTabBarItems() {
        coupleSpaceNavigationViewController.tabBarItem.title = "커플공간"
        coupleSpaceNavigationViewController.tabBarItem.image = UIImage(named: "EmptyCoupleSpaceTabImage")
        coupleSpaceNavigationViewController.tabBarItem.selectedImage = UIImage(named: "SelectedCoupleSpaceTabImage")
        
        myPageNavigationViewController.tabBarItem.title = "마이페이지"
        myPageNavigationViewController.tabBarItem.image = UIImage(named: "EmptyMypageTabImage")
        myPageNavigationViewController.tabBarItem.selectedImage = UIImage(named: "SelectedMypageTabImage")
    }
    
    private func configureTabBarViewControllers() {
        tabBarController.viewControllers = [coupleSpaceNavigationViewController, myPageNavigationViewController]
    }
    
    private func configureChildCoordinator() {
        let coupleSpaceCoordinator = CoupleSpaceCoordinator(
            navigationController: coupleSpaceNavigationViewController
        )
        coupleSpaceCoordinator.start()
    }
}

// MARK: - Public Interface
extension TabBarCoordinator {
    func start() {
        window.rootViewController = tabBarController
        
        UIView.transition(
            with: window,
            duration: 0.5,
            options: [.transitionCrossDissolve],
            animations: nil,
            completion: nil
        )
    }
}
