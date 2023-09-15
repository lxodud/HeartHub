//
//  PasswordModifyViewController.swift
//  HeartHub
//
//  Created by 이태영 on 2023/09/12.
//

import UIKit

final class PasswordModifyViewController: UIViewController {
    private let viewModel = PasswordModifyViewModel()
    private let currentPasswordTextField = HeartHubUserInfoInputTextField(
        placeholder: "기존 비밀번호를 입력하세요",
        keyboardType: .default,
        isSecureTextEntry: true
    )
    private let currentPasswordSecureButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "hidePassword"), for: .normal)
        button.setImage(UIImage(named: "showPassword"), for: .selected)
        button.titleLabel?.font = UIFont(name: "Pretendard-Regular", size: 14)
        return button
    }()
    
    private let currentPasswordDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "영문/숫자/특수문자 구성"
        label.font = UIFont(name: "Pretendard-Regular", size: 12)
        label.textAlignment = .left
        label.textColor = #colorLiteral(red: 0.46, green: 0.46, blue: 0.46, alpha: 1)
        return label
    }()
    
    private let newPasswordTextField = HeartHubUserInfoInputTextField(
        placeholder: "새 비밀번호를 입력하세요",
        keyboardType: .default,
        isSecureTextEntry: true
    )
    
    private let newPasswordSecureButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "hidePassword"), for: .normal)
        button.setImage(UIImage(named: "showPassword"), for: .selected)
        button.titleLabel?.font = UIFont(name: "Pretendard-Regular", size: 14)
        return button
    }()
    
    private let newPasswordDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "영문/숫자/특수문자 구성"
        label.font = UIFont(name: "Pretendard-Regular", size: 12)
        label.textAlignment = .left
        label.textColor = #colorLiteral(red: 0.46, green: 0.46, blue: 0.46, alpha: 1)
        return label
    }()
    
    private let passwordModifyButton: UIButton = {
        let button = UIButton(type: .custom)
        button.layer.cornerRadius = 18
        button.setTitle("비밀번호 변경하기", for: .normal)
        button.titleLabel?.font = UIFont.init(name: "Pretendard-Regular", size: 14)
        button.setTitleColor(UIColor(red: 0.067, green: 0.067, blue: 0.067, alpha: 1), for: .normal)
        button.clipsToBounds = true
        button.isEnabled = false
        let normalColor = UIColor(red: 0.98, green: 0.184, blue: 0.741, alpha: 1)
        button.setBackgroundColor(.systemGray4, for: .disabled)
        button.setBackgroundColor(normalColor, for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        configureSubview()
        configureLayout()
        configureNavigationBar()
        configureAction()
        bind(to: viewModel)
    }
    
    private func bind(to viewModel: PasswordModifyViewModel) {
        viewModel.conModifyHandler = { [weak self] canModify in
            self?.passwordModifyButton.isEnabled = canModify
        }
        
        viewModel.isSecureCurrentPasswordHandler = { [weak self] isSecure in
            self?.currentPasswordTextField.isSecureTextEntry = isSecure
        }
        
        viewModel.isSecureNewPasswordHandler = { [weak self] isSecure in
            self?.newPasswordTextField.isSecureTextEntry = isSecure
        }
    }
}

// MARK: Configure Action
extension PasswordModifyViewController {
    private func configureAction() {
        newPasswordTextField.addTarget(
            self,
            action: #selector(editNewPasswordTextField),
            for: .editingChanged
        )
        
        currentPasswordTextField.addTarget(
            self,
            action: #selector(editCurrentPasswordTextField),
            for: .editingChanged
        )
        currentPasswordSecureButton.addTarget(
            self,
            action: #selector(tapCurrentPasswordSecureButton),
            for: .touchUpInside
        )
        newPasswordSecureButton.addTarget(
            self,
            action: #selector(tapNewPasswordSecureButton),
            for: .touchUpInside
        )
        passwordModifyButton.addTarget(
            self,
            action: #selector(tapModifyButton),
            for: .touchUpInside
        )
    }
    
    @objc
    private func editCurrentPasswordTextField(_ sender: UITextField) {
        guard let password = sender.text else {
            return
        }
        
        viewModel.inputCurrentPassword(password)
    }
    
    @objc
    private func editNewPasswordTextField(_ sender: UITextField) {
        guard let password = sender.text else {
            return
        }
        
        viewModel.inputNewPassword(password)
    }
    
    @objc
    private func tapCurrentPasswordSecureButton() {
        viewModel.tapCurrentPasswordSecure()
    }
    
    @objc
    private func tapNewPasswordSecureButton() {
        viewModel.tapNewPasswordSecure()
    }
    
    @objc
    private func tapModifyButton() {
        let currentPassword = currentPasswordTextField.text
        let newPassword = newPasswordTextField.text

        viewModel.modifyPassword(current: currentPassword, new: newPassword) { message in
            DispatchQueue.main.async {
                let alert = UIAlertController(title: message, message: "", preferredStyle: .alert)
                let action = UIAlertAction(title: "확인", style: .default) { _ in
                    self.dismiss(animated: true)
                }
                alert.addAction(action)
                self.present(alert, animated: true)
            }
        }
    }
}

// MARK: Configure UI
extension PasswordModifyViewController {
    private func configureSubview() {
        [currentPasswordTextField,
         currentPasswordSecureButton,
         currentPasswordDescriptionLabel,
         newPasswordTextField,
         newPasswordSecureButton,
         newPasswordDescriptionLabel,
         passwordModifyButton
        ].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        view.backgroundColor = .systemBackground
    }
    
    private func configureLayout() {
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            // MARK: - currentPasswordTextField Constraints
            currentPasswordTextField.centerYAnchor.constraint(
                equalTo: safeArea.centerYAnchor,
                constant: -100
            ),
            currentPasswordTextField.centerXAnchor.constraint(
                equalTo: safeArea.centerXAnchor
            ),
            currentPasswordTextField.widthAnchor.constraint(
                equalTo: safeArea.widthAnchor,
                multiplier: 0.8
            ),
            currentPasswordTextField.heightAnchor.constraint(
                equalTo: safeArea.heightAnchor,
                multiplier: 0.06
            ),
            
            // MARK: - currentPasswordSecureButton Constraints
            currentPasswordSecureButton.topAnchor.constraint(
                equalTo: currentPasswordTextField.topAnchor
            ),
            currentPasswordSecureButton.trailingAnchor.constraint(
                equalTo: currentPasswordTextField.trailingAnchor,
                constant: -15
            ),
            currentPasswordSecureButton.bottomAnchor.constraint(
                equalTo: currentPasswordTextField.bottomAnchor
            ),
            
            // MARK: currentPasswordDescriptionLabel Constraints
            currentPasswordDescriptionLabel.leadingAnchor.constraint(
                equalTo: currentPasswordTextField.leadingAnchor,
                constant: 10
            ),
            currentPasswordDescriptionLabel.topAnchor.constraint(
                equalTo: currentPasswordTextField.bottomAnchor,
                constant: 8
            ),
            
            // MARK: - newPasswordTextField Constraints
            newPasswordTextField.topAnchor.constraint(
                equalTo: currentPasswordDescriptionLabel.bottomAnchor,
                constant: 10
            ),
            newPasswordTextField.centerXAnchor.constraint(
                equalTo: safeArea.centerXAnchor
            ),
            newPasswordTextField.widthAnchor.constraint(
                equalTo: safeArea.widthAnchor,
                multiplier: 0.8
            ),
            newPasswordTextField.heightAnchor.constraint(
                equalTo: safeArea.heightAnchor,
                multiplier: 0.06
            ),
            
            // MARK: - newPasswordSecureButton Constraints
            newPasswordSecureButton.topAnchor.constraint(
                equalTo: newPasswordTextField.topAnchor
            ),
            newPasswordSecureButton.trailingAnchor.constraint(
                equalTo: newPasswordTextField.trailingAnchor,
                constant: -15
            ),
            newPasswordSecureButton.bottomAnchor.constraint(
                equalTo: newPasswordTextField.bottomAnchor
            ),
            
            // MARK: - newPasswordDescriptionLabel Constraints
            newPasswordDescriptionLabel.leadingAnchor.constraint(
                equalTo: newPasswordTextField.leadingAnchor,
                constant: 10
            ),
            newPasswordDescriptionLabel.topAnchor.constraint(
                equalTo: newPasswordTextField.bottomAnchor,
                constant: 8
            ),
            
            // MARK: - passwordModifyButton Constraints
            passwordModifyButton.leadingAnchor.constraint(
                equalTo: safeArea.leadingAnchor,
                constant: 30
            ),
            passwordModifyButton.trailingAnchor.constraint(
                equalTo: safeArea.trailingAnchor,
                constant: -30
            ),
            passwordModifyButton.bottomAnchor.constraint(
                equalTo: safeArea.bottomAnchor,
                constant: -20
            ),
            passwordModifyButton.heightAnchor.constraint(
                equalTo: safeArea.heightAnchor,
                multiplier: 0.08
            ),
        ])
    }
    
    private func configureNavigationBar() {
        navigationItem.title = "비밀번호 변경"
    }
}
