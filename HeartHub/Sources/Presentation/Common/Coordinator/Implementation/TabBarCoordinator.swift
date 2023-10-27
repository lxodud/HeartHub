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
    private let coupleSpaceViewController = UINavigationController(
        rootViewController: CoupleSpaceMainViewController()
    )
    private let myPageViewController = UINavigationController(
        rootViewController: MyPageMainViewController()
    )
    
    // MARK: - initializer
    init(window: UIWindow) {
        self.window = window
        configureTabBarItems()
        configureTabBarViewControllers()
    }

    private func configureTabBarItems() {
        coupleSpaceViewController.tabBarItem.title = "커플공간"
        coupleSpaceViewController.tabBarItem.image = UIImage(named: "EmptyCoupleSpaceTabImage")
        coupleSpaceViewController.tabBarItem.selectedImage = UIImage(named: "SelectedCoupleSpaceTabImage")
        
        myPageViewController.tabBarItem.title = "마이페이지"
        myPageViewController.tabBarItem.image = UIImage(named: "EmptyMypageTabImage")
        myPageViewController.tabBarItem.selectedImage = UIImage(named: "SelectedMypageTabImage")
    }
    
    private func configureTabBarViewControllers() {
        tabBarController.viewControllers = [coupleSpaceViewController, myPageViewController]
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
