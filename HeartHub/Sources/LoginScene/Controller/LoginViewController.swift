//
//  LoginViewController.swift
//  HeartHub
//
//  Created by 제민우 on 2023/07/07.
//

import UIKit

final class LoginViewController: UIViewController {
    
    private let loginView = LoginView()
    private let loginNetwork = LoginNetwork(
        tokenRepository: TokenRepository(),
        networkManager: DefaultNetworkManager()
    )
    
    override func loadView() {
        view = loginView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAddTarget()
        
    }
    
    func setupAddTarget() {
        loginView.loginButton.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)
        loginView.findIdBtn.addTarget(self, action: #selector(didTapFindIdButton), for: .touchUpInside)
        loginView.signUpBtn.addTarget(self, action: #selector(didTapSignUpButton), for: .touchUpInside)
        loginView.findPwBtn.addTarget(self, action: #selector(didTapFindPwButton), for: .touchUpInside)
    }

    @objc private func didTapLoginButton() {
        guard let id = loginView.enterIdTextField.text,
              let password = loginView.enterPwTextField.text
        else {
            return
        }
        
        loginNetwork.login(id: id, password: password) {
            DispatchQueue.main.async {
                guard let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate,
                      let window = sceneDelegate.window
                else {
                    return
                }
                
                window.rootViewController = HeartHubTabBarController()
                UIView.transition(
                    with: window,
                    duration: 0.2,
                    options: [.transitionCrossDissolve],
                    animations: nil,
                    completion: nil
                )
            }
        }
    }
    
    @objc private func didTapFindPwButton() {
         let findPwVC = FindPwViewController()
        navigationController?.pushViewController(findPwVC, animated: true)

    }
    
    @objc private func didTapSignUpButton() {
        let signUpVC = SignUpStartDateViewController()
        navigationController?.pushViewController(signUpVC, animated: true)

    }
    
    @objc private func didTapFindIdButton() {
        let findIdVC = FindIdViewController()
        navigationController?.pushViewController(findIdVC, animated: true)
    }
}
