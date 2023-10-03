//
//  NicknameEmailInputViewController.swift
//  HeartHub
//
//  Created by 이태영 on 2023/09/28.
//

import UIKit

final class NicknameEmailInputViewController: UIViewController {
    private let titleLabel = SignUpTitleLabelStackView(
        title: "사랑을 시작해볼까요?",
        description: "계정을 생성하여 HeartHub를 즐겨보아요."
    )
    
    private let nicknameTextField = HeartHubUserInfoInputTextField(
        placeholder: "닉네임을 입력하세요",
        keyboardType: .default,
        isSecureTextEntry: false
    )
    private let nicknameCheckButton: UIButton = {
        let button = UIButton()
        button.setTitle("중복 확인", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.setTitleColor(UIColor(red: 0.46, green: 0.46, blue: 0.46, alpha: 1), for: .disabled)
        button.titleLabel?.font = UIFont(name: "Pretendard-Regular", size: 14)
        let normalColor = UIColor(red: 0.98, green: 0.184, blue: 0.741, alpha: 1)
        button.setBackgroundColor(normalColor, for: .normal)
        button.setBackgroundColor(.systemGray3, for: .disabled)
        button.clipsToBounds = true
        button.layer.cornerRadius = 18
        return button
    }()
    private let nicknameDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "영문/숫자/특수문자 구성"
        label.font = UIFont(name: "Pretendard-Regular", size: 12)
        label.textColor = UIColor(red: 0.46, green: 0.46, blue: 0.46, alpha: 1)
        return label
    }()
    
    private let emailTextField = HeartHubUserInfoInputTextField(
        placeholder: "이메일을 입력하세요",
        keyboardType: .default,
        isSecureTextEntry: false
    )
    private let emailAuthenticationButton: UIButton = {
        let button = UIButton()
        button.setTitle("인증", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.setTitleColor(UIColor(red: 0.46, green: 0.46, blue: 0.46, alpha: 1), for: .disabled)
        button.titleLabel?.font = UIFont(name: "Pretendard-Regular", size: 14)
        let normalColor = UIColor(red: 0.98, green: 0.184, blue: 0.741, alpha: 1)
        button.setBackgroundColor(normalColor, for: .normal)
        button.setBackgroundColor(.systemGray3, for: .disabled)
        button.clipsToBounds = true
        button.layer.cornerRadius = 18
        return button
    }()
    
    private let authenticationNumberTextField = HeartHubUserInfoInputTextField(
        placeholder: "인증번호를 입력하세요",
        keyboardType: .default,
        isSecureTextEntry: false
    )
    private let authenticationNumberCheckButton: UIButton = {
        let button = UIButton()
        button.setTitle("확인", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.setTitleColor(UIColor(red: 0.46, green: 0.46, blue: 0.46, alpha: 1), for: .disabled)
        button.titleLabel?.font = UIFont(name: "Pretendard-Regular", size: 14)
        let normalColor = UIColor(red: 0.98, green: 0.184, blue: 0.741, alpha: 1)
        button.setBackgroundColor(normalColor, for: .normal)
        button.setBackgroundColor(.systemGray3, for: .disabled)
        button.clipsToBounds = true
        button.layer.cornerRadius = 18
        return button
    }()
    
    private let nextButton: UIButton = SignUpBottomButton(title: "다음")
    
    private let activityIndicator = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        configureSuperview()
        configureSubview()
        configureLayout()
    }
}

// MARK: - Configure UI
extension NicknameEmailInputViewController {
    private func configureSuperview() {
        view.backgroundColor = .systemBackground
    }
    
    private func configureSubview() {
        [titleLabel,
         nicknameTextField,
         nicknameCheckButton,
         nicknameDescriptionLabel,
         emailTextField,
         emailAuthenticationButton,
         authenticationNumberTextField,
         authenticationNumberCheckButton,
         nextButton,
         activityIndicator].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    private func configureLayout() {
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            // MARK: - titleLabel Constraints
            titleLabel.centerYAnchor.constraint(
                equalTo: safeArea.centerYAnchor,
                constant: -(view.bounds.height * 0.35)
            ),
            titleLabel.centerXAnchor.constraint(
                equalTo: safeArea.centerXAnchor
            ),
            titleLabel.widthAnchor.constraint(
                equalTo: safeArea.widthAnchor,
                multiplier: 0.8
            ),
            
            // MARK: - nicknameTextField Constratins
            nicknameTextField.topAnchor.constraint(
                equalTo: titleLabel.bottomAnchor,
                constant: 30
            ),
            nicknameTextField.centerXAnchor.constraint(
                equalTo: safeArea.centerXAnchor
            ),
            nicknameTextField.widthAnchor.constraint(
                equalTo: safeArea.widthAnchor,
                multiplier: 0.85
            ),
            nicknameTextField.heightAnchor.constraint(
                equalToConstant: 35
            ),
            
            // MARK: - nicknameCheckButton Constraints
            nicknameCheckButton.topAnchor.constraint(
                equalTo: nicknameTextField.topAnchor
            ),
            nicknameCheckButton.trailingAnchor.constraint(
                equalTo: nicknameTextField.trailingAnchor
            ),
            nicknameCheckButton.bottomAnchor.constraint(
                equalTo: nicknameTextField.bottomAnchor
            ),
            nicknameCheckButton.widthAnchor.constraint(
                equalTo: nicknameTextField.widthAnchor,
                multiplier: 0.2
            ),
            
            // MARK: - nicknameDescriptionLabel Constraints
            nicknameDescriptionLabel.topAnchor.constraint(
                equalTo: nicknameTextField.bottomAnchor,
                constant: 5
            ),
            nicknameDescriptionLabel.leadingAnchor.constraint(
                equalTo: nicknameTextField.leadingAnchor,
                constant: 15
            ),
            
            // MARK: - emailTextField Constraints
            emailTextField.topAnchor.constraint(
                equalTo: nicknameTextField.bottomAnchor,
                constant: 30
            ),
            emailTextField.centerXAnchor.constraint(
                equalTo: nicknameTextField.centerXAnchor
            ),
            emailTextField.widthAnchor.constraint(
                equalTo: nicknameTextField.widthAnchor
            ),
            emailTextField.heightAnchor.constraint(
                equalTo: nicknameTextField.heightAnchor
            ),
            
            // MARK: emailAuthenticationButton Constraints
            emailAuthenticationButton.topAnchor.constraint(
                equalTo: emailTextField.topAnchor
            ),
            emailAuthenticationButton.trailingAnchor.constraint(
                equalTo: emailTextField.trailingAnchor
            ),
            emailAuthenticationButton.bottomAnchor.constraint(
                equalTo: emailTextField.bottomAnchor
            ),
            emailAuthenticationButton.widthAnchor.constraint(
                equalTo: emailTextField.widthAnchor,
                multiplier: 0.2
            ),
            
            // MARK: authenticationNumberTextField Constratints
            authenticationNumberTextField.topAnchor.constraint(
                equalTo: emailTextField.bottomAnchor,
                constant: 10
            ),
            authenticationNumberTextField.centerXAnchor.constraint(
                equalTo: emailTextField.centerXAnchor
            ),
            authenticationNumberTextField.widthAnchor.constraint(
                equalTo: emailTextField.widthAnchor
            ),
            authenticationNumberTextField.heightAnchor.constraint(
                equalTo: emailTextField.heightAnchor
            ),
            
            // MARK: authenticationNumberCheckButton Constraints
            authenticationNumberCheckButton.topAnchor.constraint(
                equalTo: authenticationNumberTextField.topAnchor
            ),
            authenticationNumberCheckButton.trailingAnchor.constraint(
                equalTo: authenticationNumberTextField.trailingAnchor
            ),
            authenticationNumberCheckButton.bottomAnchor.constraint(
                equalTo: authenticationNumberTextField.bottomAnchor
            ),
            authenticationNumberCheckButton.widthAnchor.constraint(
                equalTo: authenticationNumberTextField.widthAnchor,
                multiplier: 0.2
            ),
            
            // MARK: - nextButton Constraints
            nextButton.bottomAnchor.constraint(
                equalTo: safeArea.bottomAnchor,
                constant: -30
            ),
            nextButton.centerXAnchor.constraint(
                equalTo: safeArea.centerXAnchor
            ),
            nextButton.widthAnchor.constraint(
                equalTo: safeArea.widthAnchor,
                multiplier: 0.85
            ),
            
            // MARK: activityIndicator Constraints
            activityIndicator.centerXAnchor.constraint(
                equalTo: safeArea.centerXAnchor
            ),
            activityIndicator.centerYAnchor.constraint(
                equalTo: safeArea.centerYAnchor
            ),
        ])
    }
}
