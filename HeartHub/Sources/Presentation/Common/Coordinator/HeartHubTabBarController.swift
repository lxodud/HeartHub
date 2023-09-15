//
//  HeartHubTabBarController.swift
//  HeartHub
//
//  Created by 이태영 on 2023/08/04.
//

import UIKit

final class HeartHubTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTabBarItems()
    }

    private func configureTabBarInitialSetting() {
    }

    private func configureTabBarItems() {

        let coupleSpaceViewController = UINavigationController(
            rootViewController: CoupleSpaceMainViewController()
        )
        coupleSpaceViewController.tabBarItem.title = "커플공간"
        coupleSpaceViewController.tabBarItem.image = UIImage(named: "EmptyCoupleSpaceTabImage")
        coupleSpaceViewController.tabBarItem.selectedImage = UIImage(named: "SelectedCoupleSpaceTabImage")
        
        let myPageViewController = UINavigationController(
            rootViewController: MyPageMainViewController()
        )
        
        myPageViewController.tabBarItem.title = "마이페이지"
        myPageViewController.tabBarItem.image = UIImage(named: "EmptyMypageTabImage")
        myPageViewController.tabBarItem.selectedImage = UIImage(named: "SelectedMypageTabImage")
        
        
        setViewControllers(
            [coupleSpaceViewController, myPageViewController],
            animated: true
        )
    }
}
