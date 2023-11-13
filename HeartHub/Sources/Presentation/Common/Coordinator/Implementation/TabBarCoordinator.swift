//
//  TabBarCoordinator.swift
//  HeartHub
//
//  Created by 이태영 on 2023/08/04.
//

import UIKit

final class TabBarCoordinator: TabBarCoordinatable {
    private let window: UIWindow
    private let finishDelegate: CoordinatorFinishDelegate
    private let tabBarController = UITabBarController()
    private let coupleSpaceNavigationViewController = UINavigationController()
    private let myPageNavigationViewController = UINavigationController()
    
    // MARK: - initializer
    init(
        window: UIWindow,
        finishDelegate: CoordinatorFinishDelegate
    ) {
        self.window = window
        self.finishDelegate = finishDelegate
        configureTabBarItems()
        configureTabBarViewControllers()
        configureChildCoordinator()

        tabBarController.tabBar.backgroundColor = .systemBackground
        tabBarController.tabBar.tintColor = .black
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
        
        let myPageCoordinator = MyPageCoordinator(
            navigationController: myPageNavigationViewController,
            finishDelegate: self
        )
        myPageCoordinator.start()
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

// MARK: MyPageFinishDelegate Implementation
extension TabBarCoordinator: MyPageFinishDelegate {
    func finish() {
        finishDelegate.finish(coordinator: self)
    }
}
