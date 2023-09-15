//
//  SceneDelegate.swift
//  HeartHub
//
//  Created by 이태영 on 2023/07/03.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    private var appCoordinator: Coordinatable?
    
    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        
        let navigationController = UINavigationController()
        window?.rootViewController = navigationController
        appCoordinator = AppCoordinator(navigationController: navigationController)
        appCoordinator?.start()
        
        self.window?.backgroundColor = .systemBackground
        self.window?.makeKeyAndVisible()
    }
}
