//
//  PasswordModifyViewController.swift
//  HeartHub
//
//  Created by 이태영 on 2023/09/12.
//

import RxCocoa
import RxSwift
import UIKit

final class PasswordModifyViewController: UIViewController {
    private let viewModel = PasswordModifyViewModel()
    private let disposeBag = DisposeBag()
    private let currentPasswordTextField = HeartHubUserInfoInputTextField(
        placeholder: "기존 비밀번호를 입력하세요",
        keyboardType: .default,
        isSecureTextEntry: true
    )
    private let currentPasswordSecureButton: UIButton = {
        let button = UIButton()
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
        let button = UIButton()
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
        let button = UIButton()
        button.layer.cornerRadius = 18
        button.setTitle("비밀번호 변경하기", for: .normal)
        button.titleLabel?.font = UIFont.init(name: "Pretendard-Regular", size: 14)
        button.setTitleColor(UIColor(red: 0.067, green: 0.067, blue: 0.067, alpha: 1), for: .normal)
        button.setTitleColor(.systemGray, for: .disabled)
        
        let normalColor = UIColor(red: 0.98, green: 0.184, blue: 0.741, alpha: 1)
        button.setBackgroundColor(.systemGray4, for: .disabled)
        button.setBackgroundColor(normalColor, for: .normal)
        
        button.clipsToBounds = true
        return button
    }()
    
    private let activityIndicator = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        configureSuperview()
        configureSubview()
        configureLayout()
        configureNavigationBar()
        bind(to: viewModel)
        bindUI()
    }
    
    private func bind(to viewModel: PasswordModifyViewModel) {
        let input = PasswordModifyViewModel.Input(
            currentPassword: currentPasswordTextField.rx.text.orEmpty.asDriver(),
            newPassword: newPasswordTextField.rx.text.orEmpty.asDriver(),
            tapCurrentPasswodSecure: currentPasswordSecureButton.rx.tap.asDriver(),
            tapNewPasswodSecure: newPasswordSecureButton.rx.tap.asDriver(),
            tapModify: passwordModifyButton.rx.tap.asDriver()
        )
        
        let output = viewModel.transform(input)
        
        output.canModify
            .drive(passwordModifyButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        output.isCurrentPasswordSecure
            .drive(currentPasswordTextField.rx.isSecureTextEntry)
            .disposed(by: disposeBag)
        
        output.isCurrentPasswordSecure
            .map { !$0 }
            .drive(currentPasswordSecureButton.rx.isSelected)
            .disposed(by: disposeBag)
        
        output.isNewPasswordSecure
            .drive(newPasswordTextField.rx.isSecureTextEntry)
            .disposed(by: disposeBag)
        
        output.isNewPasswordSecure
            .map { !$0 }
            .drive(newPasswordSecureButton.rx.isSelected)
            .disposed(by: disposeBag)
        
        output.modifying
            .drive(activityIndicator.rx.isAnimating)
            .disposed(by: disposeBag)
        
        output.modifyed
            .drive()
            .disposed(by: disposeBag)
        // TODO: 실패했을 때 에러처리
    }
    
    private func bindUI() {
        let tapBackground = UITapGestureRecognizer()
        view.addGestureRecognizer(tapBackground)
        
        tapBackground.rx.event
            .subscribe(onNext: { [weak self] _ in
                self?.view.endEditing(true)
            })
            .disposed(by: disposeBag)
    }
}

// MARK: Configure UI
extension PasswordModifyViewController {
    private func configureSuperview() {
        view.backgroundColor = .systemBackground
    }
    
    private func configureSubview() {
        [currentPasswordTextField,
         currentPasswordSecureButton,
         currentPasswordDescriptionLabel,
         newPasswordTextField,
         newPasswordSecureButton,
         newPasswordDescriptionLabel,
         passwordModifyButton,
         activityIndicator
        ].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
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
            
            // MARK: activityIndicator Constraints
            activityIndicator.centerXAnchor.constraint(
                equalTo: safeArea.centerXAnchor
            ),
            activityIndicator.centerYAnchor.constraint(
                equalTo: safeArea.centerYAnchor
            ),
        ])
    }
    
    private func configureNavigationBar() {
        navigationItem.title = "비밀번호 변경"
    }
}
