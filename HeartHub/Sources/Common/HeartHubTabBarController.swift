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
        
        setViewControllers(
            [coupleSpaceViewController],
            animated: true
        )
    }
}
