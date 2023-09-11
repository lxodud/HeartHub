//
//  ProfileModifyViewController.swift
//  HeartHub
//
//  Created by 이태영 on 2023/09/08.
//

import UIKit

final class ProfileModifyViewController: UIViewController {
    private let viewModel: ProfileModifyViewModel
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.isUserInteractionEnabled = true
        imageView.layer.cornerRadius = 20
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let decorateImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "profileImageCamera")
        return imageView
    }()
    
    private let nicknameTextField: UITextField = {
        let textField = UITextField()
        textField.font = UIFont(name: "Pretendard-Regular", size: 20)
        textField.textAlignment = .center
        textField.attributedPlaceholder = NSAttributedString(
            string: "닉네임을 작성해주세요",
            attributes: [
                NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.07, green: 0.07, blue: 0.07, alpha: 0.5),
                NSAttributedString.Key.font: UIFont(name: "Pretendard-Regular", size: 20)!
            ]
        )
        
        return textField
    }()
    
    private let profileModifyButton: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = .white
        button.layer.cornerRadius = 18
        
        button.setTitle("프로필로 적용하기", for: .normal)
        button.titleLabel?.font = UIFont.init(name: "Pretendard-Regular", size: 14)
        button.titleLabel?.textAlignment = .center
        button.setTitleColor(UIColor(red: 0.067, green: 0.067, blue: 0.067, alpha: 1), for: .normal)
        button.backgroundColor = .systemGray4
        return button
    }()
    
    private let activicyIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        return indicator
    }()
    
    init(
        viewModel: ProfileModifyViewModel = ProfileModifyViewModel()
    ) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        configureSubview()
        configureLayout()
        configureNavigationBar()
        configureAction()
        bind(to: viewModel)
        viewModel.fetchProfileImage()
    }
    
    func bind(to viewModel: ProfileModifyViewModel) {
        viewModel.profileImageHandler = { [weak self] imageData in
            guard let imageData = imageData else {
                self?.profileImageView.image = UIImage(named: "basicProfileImage")
                return
            }
            
            self?.profileImageView.image = UIImage(data: imageData)
        }
        viewModel.canModifyHandler = { [weak self] canModify in
            self?.profileModifyButton.isEnabled = canModify
            if canModify {
                self?.profileModifyButton.backgroundColor = UIColor(red: 0.98, green: 0.184, blue: 0.741, alpha: 1)
            } else {
                self?.profileModifyButton.backgroundColor = .systemGray4
            }
            
        }
    }
}

// MARK: - Configure Action
extension ProfileModifyViewController {
    private func configureAction() {
        let tapGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(tapProfileImageView)
        )
        
        profileImageView.addGestureRecognizer(tapGesture)
        profileModifyButton.addTarget(
            self,
            action: #selector(tapProfileEditButton),
            for: .touchUpInside
        )
        nicknameTextField.addTarget(
            self,
            action: #selector(textFieldDidChanged),
            for: .editingChanged
        )
    }
    
    @objc
    private func tapProfileEditButton() {
        let nickname = nicknameTextField.text
        activicyIndicator.startAnimating()
        
        viewModel.modifyProfile(with: nickname) { message in
            DispatchQueue.main.async {
                self.activicyIndicator.stopAnimating()
                
                let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
                self.present(alert, animated: true) {
                    self.dismiss(animated: true)
                }
            }
        }
    }
    
    @objc
    private func tapProfileImageView() {
        let imagePickerViewController = HeartHubImagePickerViewController()
        imagePickerViewController.delegate = viewModel
        let imagePickerNavigationViewController = UINavigationController(
            rootViewController: imagePickerViewController
        )
        imagePickerNavigationViewController.modalPresentationStyle = .fullScreen
        navigationController?.present(imagePickerNavigationViewController, animated: true)
    }
    
    @objc
    private func textFieldDidChanged() {
        guard let nickname = nicknameTextField.text else {
            return
        }
        
        viewModel.changeModifyState(!nickname.isEmpty)
    }
}

// MARK: - UITextField Delegate Implementation
extension ProfileModifyViewController: UITextFieldDelegate {
    func textField(
        _ textField: UITextField,
        shouldChangeCharactersIn range: NSRange,
        replacementString string: String
    ) -> Bool {
        if textField.text?.count == 1 && string == " " {
            return false
        }
        
        if let char = string.cString(using: String.Encoding.utf8) {
            let isBackSpace = strcmp(char, "\\b")
            if isBackSpace == -92 {
                return true
            }
        }
        
        guard let text = textField.text else {
            return true
        }
        
        let maxLength = 10
        let allowedCharacterSet = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#$%^&*()-_?+=~")
            .union(CharacterSet(charactersIn: "\u{AC00}"..."\u{D7A3}"))
            .union(CharacterSet(charactersIn: "\u{3131}"..."\u{314E}"))
            .union(CharacterSet(charactersIn: "\u{314F}"..."\u{3163}"))
        
        let newLength = text.count + string.count - range.length
        
        if newLength <= maxLength {
            let characterSet = CharacterSet(charactersIn: string)
            return allowedCharacterSet.isSuperset(of: characterSet)
        } else {
            return false
        }
    }
}

// MARK: - Configure UI
extension ProfileModifyViewController {
    private func configureSubview() {
        [profileImageView, nicknameTextField, profileModifyButton, activicyIndicator].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        profileImageView.addSubview(decorateImageView)
        decorateImageView.translatesAutoresizingMaskIntoConstraints = false
        
        nicknameTextField.delegate = self
        
        view.backgroundColor = .systemBackground
    }
    
    private func configureLayout() {
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            // MARK: - profileImageView Constraints
            profileImageView.topAnchor.constraint(
                equalTo: safeArea.topAnchor,
                constant: 30
            ),
            profileImageView.centerXAnchor.constraint(
                equalTo: safeArea.centerXAnchor
            ),
            profileImageView.heightAnchor.constraint(
                equalTo: safeArea.heightAnchor,
                multiplier: 0.25
            ),
            profileImageView.widthAnchor.constraint(
                equalTo: profileImageView.heightAnchor
            ),
            
            // MARK: - decorateImageView Constraints
            decorateImageView.trailingAnchor.constraint(
                equalTo: profileImageView.trailingAnchor,
                constant: -10
            ),
            decorateImageView.bottomAnchor.constraint(
                equalTo: profileImageView.bottomAnchor,
                constant: -10
            ),
            decorateImageView.heightAnchor.constraint(
                equalTo: profileImageView.heightAnchor,
                multiplier: 0.15
            ),
            decorateImageView.widthAnchor.constraint(
                equalTo: decorateImageView.heightAnchor
            ),
            
            // MARK: - nicknameTextField Constraints
            nicknameTextField.topAnchor.constraint(
                equalTo: profileImageView.bottomAnchor,
                constant: 30
            ),
            nicknameTextField.centerXAnchor.constraint(
                equalTo: safeArea.centerXAnchor
            ),
            nicknameTextField.widthAnchor.constraint(
                equalTo: safeArea.widthAnchor,
                multiplier: 0.7
            ),
            
            // MARK: - profileEditButton Constraints
            profileModifyButton.leadingAnchor.constraint(
                equalTo: safeArea.leadingAnchor,
                constant: 30
            ),
            profileModifyButton.trailingAnchor.constraint(
                equalTo: safeArea.trailingAnchor,
                constant: -30
            ),
            profileModifyButton.bottomAnchor.constraint(
                equalTo: safeArea.bottomAnchor,
                constant: -20
            ),
            profileModifyButton.heightAnchor.constraint(
                equalTo: safeArea.heightAnchor,
                multiplier: 0.08
            ),
            
            // MARK: - activiryIndicator Constraints
            activicyIndicator.centerXAnchor.constraint(
                equalTo: safeArea.centerXAnchor
            ),
            activicyIndicator.centerYAnchor.constraint(
                equalTo: safeArea.centerYAnchor
            )
        ])
    }
    
    private func configureNavigationBar() {
        navigationItem.title = "프로필 수정"
    }
}
