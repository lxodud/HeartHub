//
//  SceneDelegate.swift
//  HeartHub
//
//  Created by 이태영 on 2023/07/03.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    
    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        
        let tokenRepository = TokenRepository()
        
        if let _ = tokenRepository.fetchAccessToken() {
            let heartHubTabBarController = HeartHubTabBarController()
            self.window?.rootViewController = heartHubTabBarController
        } else {
            let loginVC = LoginViewController()
            let navigationController = UINavigationController(rootViewController: loginVC)
            navigationController.isNavigationBarHidden = true
            self.window?.rootViewController = navigationController
        }
        
        self.window?.backgroundColor = .systemBackground
        self.window?.makeKeyAndVisible()
    }
}
