//
//  SignUp3ViewController.swift
//  test
//
//  Created by 제민우 on 2023/07/08.
//


import UIKit

final class SignUpEnterNickNameEmailViewController: UIViewController {
    
    private let signUpLoverLinkingView = SignUpEnterNickNameEmailView()
    private let userInformationManager: SignUpManager
    
    init(userInformationManager: SignUpManager) {
        self.userInformationManager = userInformationManager
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = signUpLoverLinkingView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureAddTarget()
    }
}

// MARK: Configure AddTarget
extension SignUpEnterNickNameEmailViewController {
    private func configureAddTarget() {
        signUpLoverLinkingView.signUpLoverNextPageButton.addTarget(self, action: #selector(didTapNextPageButton), for: .touchUpInside)
        signUpLoverLinkingView.signUpLoverPreviousPageButton.addTarget(self, action: #selector(didTapPreviousPageButton), for: .touchUpInside)
        signUpLoverLinkingView.emailVerifyButton.addTarget(self, action: #selector(didTapemailVerifyButton), for: .touchUpInside)
        signUpLoverLinkingView.nickNameCheckButton.addTarget(self, action: #selector(didTapNickNameCheckButton), for: .touchUpInside)
    }
    
    @objc private func didTapNickNameCheckButton() {
        guard let nickname = signUpLoverLinkingView.nickNameTextField.text else {
            return
        }
        
        userInformationManager.checkNicknameAvailability(with: nickname) { isNotDuplicate in
            DispatchQueue.main.async {
                if isNotDuplicate {
                    self.signUpLoverLinkingView.nickNameDescriptionLabel.text = "사용 가능한 닉네임입니다."
                    self.signUpLoverLinkingView.nickNameDescriptionLabel.textColor = UIColor(
                        red: 0.105,
                        green: 0.751,
                        blue: 0.325,
                        alpha: 1
                    )
                    
                } else {
                    self.signUpLoverLinkingView.nickNameDescriptionLabel.text = "중복된 닉네임입니다."
                    self.signUpLoverLinkingView.nickNameDescriptionLabel.textColor = UIColor(
                        red: 1,
                        green: 0.004,
                        blue: 0.004,
                        alpha: 1
                    )
                }
            }
        }
        
    }
    
    @objc private func didTapNextPageButton() {
        let signUpTermAgreeVC = SignUpTermAgreeViewController(userInformationManager: userInformationManager)
        navigationController?.pushViewController(signUpTermAgreeVC, animated: true)
    }
    
    @objc private func didTapPreviousPageButton() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func didTapemailVerifyButton() {
        guard let email = signUpLoverLinkingView.emailTextField.text else {
            return
        }
        
        userInformationManager.sendVerificationCodeToEmail(with: email)
    }
}
