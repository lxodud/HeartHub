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

//        appCoordinator = AppCoordinator(window: window ?? UIWindow())
//        appCoordinator?.start()
        
        let vc = TermAgreeViewController(viewModel: TermAgreeViewModel())
        
        self.window?.rootViewController = vc
        self.window?.backgroundColor = .systemBackground
        self.window?.makeKeyAndVisible()
    }
}
