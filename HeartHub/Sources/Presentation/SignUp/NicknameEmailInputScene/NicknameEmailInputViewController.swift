//
//  NicknameEmailInputViewController.swift
//  HeartHub
//
//  Created by 이태영 on 2023/09/28.
//

import RxCocoa
import RxSwift
import UIKit

final class NicknameEmailInputViewController: UIViewController {
    private let viewModel: NicknameEmailInputViewModel
    private let disposeBag = DisposeBag()
    
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
    private let verificationCodeSendButton: UIButton = {
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
    private let emailDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Pretendard-Regular", size: 12)
        return label
    }()
    
    private let verificationCodeTextField = HeartHubUserInfoInputTextField(
        placeholder: "인증번호를 입력하세요",
        keyboardType: .numberPad,
        isSecureTextEntry: false,
        isHidden: true
    )
    private let verificationCodeCheckButton: UIButton = {
        let button = UIButton()
        button.setTitle("확인", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.setTitleColor(UIColor(red: 0.46, green: 0.46, blue: 0.46, alpha: 1), for: .disabled)
        button.titleLabel?.font = UIFont(name: "Pretendard-Regular", size: 14)
        let normalColor = UIColor(red: 0.98, green: 0.184, blue: 0.741, alpha: 1)
        button.setBackgroundColor(normalColor, for: .normal)
        button.setBackgroundColor(.systemGray3, for: .disabled)
        button.clipsToBounds = true
        button.isHidden = true
        button.layer.cornerRadius = 18
        return button
    }()
    private let verificationCodeCheckDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Pretendard-Regular", size: 12)
        return label
    }()
    
    private let nextButton: UIButton = SignUpBottomButton(title: "다음")
    
    private let activityIndicator = UIActivityIndicatorView()
    
    // initializer
    init(viewModel: NicknameEmailInputViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        configureSuperview()
        configureSubview()
        configureLayout()
        bind(to: viewModel)
        bindUI()
    }
    
    private func bind(to viewModel: NicknameEmailInputViewModel) {
        let input = NicknameEmailInputViewModel.Input(
            nickname: nicknameTextField.rx.text.orEmpty.asDriver(),
            tapCheckNicknameDuplication: nicknameCheckButton.rx.tap.asDriver(),
            email: emailTextField.rx.text.orEmpty.asDriver(),
            tapVerificationCodeSend: verificationCodeSendButton.rx.tap.asDriver(),
            verificationCode: verificationCodeTextField.rx.text.orEmpty.asDriver(),
            tapVerificationCodeCheck: verificationCodeCheckButton.rx.tap.asDriver()
        )
        
        let output = viewModel.transform(input)
        
        output.verifiedNickname
            .drive(nicknameTextField.rx.text)
            .disposed(by: disposeBag)
        
        output.checkingDuplicationNickname
            .drive(activityIndicator.rx.isAnimating)
            .disposed(by: disposeBag)
        
        output.isCheckNicknameDuplicationEnable
            .drive(nicknameCheckButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        output.nicknameDescription
            .drive(nicknameDescriptionLabel.rx.text)
            .disposed(by: disposeBag)
        
        output.nicknameDescriptionColor
            .drive(onNext: { [weak self] in
                self?.nicknameDescriptionLabel.textColor = $0.uiColor
            })
            .disposed(by: disposeBag)
        
        output.isVerificationCodeSendEnable
            .drive(verificationCodeSendButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        output.emailDescription
            .drive(emailDescriptionLabel.rx.text)
            .disposed(by: disposeBag)
        
        output.emailDescriptionColor
            .drive(onNext: { [weak self] in
                self?.emailDescriptionLabel.textColor = $0.uiColor
            })
            .disposed(by: disposeBag)
        
        output.isInputVerificationCodeEnable
            .map { !$0 }
            .drive(
                verificationCodeTextField.rx.isHidden,
                verificationCodeCheckButton.rx.isHidden,
                verificationCodeCheckDescriptionLabel.rx.isHidden
            )
            .disposed(by: disposeBag)
        
        output.sendingVerificationCode
            .drive(activityIndicator.rx.isAnimating)
            .disposed(by: disposeBag)
        
        output.isCheckVerificationCodeEnable
            .drive(verificationCodeCheckButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        output.verificationCodeCheckDescription
            .drive(verificationCodeCheckDescriptionLabel.rx.text)
            .disposed(by: disposeBag)
        
        output.verificationCodeCheckDescriptionColor
            .drive(onNext: { [weak self] in
                self?.verificationCodeCheckDescriptionLabel.textColor = $0.uiColor
            })
            .disposed(by: disposeBag)
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
         verificationCodeSendButton,
         emailDescriptionLabel,
         verificationCodeTextField,
         verificationCodeCheckButton,
         verificationCodeCheckDescriptionLabel,
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
            verificationCodeSendButton.topAnchor.constraint(
                equalTo: emailTextField.topAnchor
            ),
            verificationCodeSendButton.trailingAnchor.constraint(
                equalTo: emailTextField.trailingAnchor
            ),
            verificationCodeSendButton.bottomAnchor.constraint(
                equalTo: emailTextField.bottomAnchor
            ),
            verificationCodeSendButton.widthAnchor.constraint(
                equalTo: emailTextField.widthAnchor,
                multiplier: 0.2
            ),
            
            // MARK: - emailDescriptionLabel Constraints
            emailDescriptionLabel.topAnchor.constraint(
                equalTo: emailTextField.bottomAnchor,
                constant: 5
            ),
            emailDescriptionLabel.leadingAnchor.constraint(
                equalTo: emailTextField.leadingAnchor,
                constant: 15
            ),
            
            // MARK: authenticationNumberTextField Constratints
            verificationCodeTextField.topAnchor.constraint(
                equalTo: emailDescriptionLabel.bottomAnchor,
                constant: 10
            ),
            verificationCodeTextField.centerXAnchor.constraint(
                equalTo: emailTextField.centerXAnchor
            ),
            verificationCodeTextField.widthAnchor.constraint(
                equalTo: emailTextField.widthAnchor
            ),
            verificationCodeTextField.heightAnchor.constraint(
                equalTo: emailTextField.heightAnchor
            ),
            
            // MARK: authenticationNumberCheckButton Constraints
            verificationCodeCheckButton.topAnchor.constraint(
                equalTo: verificationCodeTextField.topAnchor
            ),
            verificationCodeCheckButton.trailingAnchor.constraint(
                equalTo: verificationCodeTextField.trailingAnchor
            ),
            verificationCodeCheckButton.bottomAnchor.constraint(
                equalTo: verificationCodeTextField.bottomAnchor
            ),
            verificationCodeCheckButton.widthAnchor.constraint(
                equalTo: verificationCodeTextField.widthAnchor,
                multiplier: 0.2
            ),
            
            // MARK: - verificationCodeDescriptionLabel Constraints
            verificationCodeCheckDescriptionLabel.topAnchor.constraint(
                equalTo: verificationCodeTextField.bottomAnchor,
                constant: 5
            ),
            verificationCodeCheckDescriptionLabel.leadingAnchor.constraint(
                equalTo: verificationCodeTextField.leadingAnchor,
                constant: 15
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
