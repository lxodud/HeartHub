//
//  FindPasswordViewController.swift
//  HeartHub
//
//  Created by 이태영 on 2023/09/22.
//

import RxCocoa
import RxSwift
import UIKit

final class FindPasswordViewController: UIViewController {
    private let viewModel: FindPasswordViewModel
    private let disposeBag = DisposeBag()
    
    private let backgroundView = LoginBackgroundView()
    private let activityIndicator = UIActivityIndicatorView()
    
    private let idTextField = LoginTextField(
        placeholder: "아이디를 입력하세요",
        keyboardType: .default
    )
    
    private let emailTextField = LoginTextField(
        placeholder: "이메일을 입력하세요",
        keyboardType: .default,
        isSecureTextEntry: true
    )
    
    private let findPasswordButton: UIButton = {
        let button = UIButton(type: .custom)
        button.layer.cornerRadius = 8
        button.clipsToBounds = true
        button.setTitle("비밀번호 찾기", for: .normal)
        button.titleLabel?.font = UIFont.init(name: "Pretendard-SemiBold", size: 16)
        button.setTitleColor(UIColor(red: 0.98, green: 0.18, blue: 0.74, alpha: 1), for: .normal)
        button.setTitleColor(.white, for: .disabled)
        button.setBackgroundColor(.white, for: .normal)
        button.setBackgroundColor(.systemGray4, for: .disabled)
        button.contentVerticalAlignment = .center
        return button
    }()
    
    private let idPasswordLoginStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 8
        return stackView
    }()
    
    private let toFindIdButton: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = .clear
        button.setTitle("아이디 찾기", for: .normal)
        button.titleLabel?.textAlignment = .center
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.init(name: "Pretendard-Regular", size: 16)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.titleLabel?.numberOfLines = 1
        return button
    }()
    
    private let toSignUpButton: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = .clear
        button.setTitle("회원가입", for: .normal)
        button.titleLabel?.textAlignment = .center
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.init(name: "Pretendard-Regular", size: 16)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.titleLabel?.numberOfLines = 1
        return button
    }()
    
    private let toLoginButton: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = .clear
        button.setTitle("로그인", for: .normal)
        button.titleLabel?.textAlignment = .center
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.init(name: "Pretendard-Regular", size: 16)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.titleLabel?.numberOfLines = 1
        return button
    }()
    
    private let toFindSignButtonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fillProportionally
        stackView.spacing = 8
        return stackView
    }()
    
    private let firstSeperateView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private let secondSeperateView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    // MARK: - initializer
    init(viewModel: FindPasswordViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSubview()
        configureLayout()
        bind(to: viewModel)
        bindUI()
    }
    
    private func bind(to viewModel: FindPasswordViewModel) {
        let input = FindPasswordViewModel.Input(
            id: idTextField.rx.text.orEmpty.asDriver(),
            email: emailTextField.rx.text.orEmpty.asDriver(),
            findPasswordTap: findPasswordButton.rx.tap.asDriver(),
            toFindIdTap: toFindIdButton.rx.tap.asDriver(),
            toLoginTap: toLoginButton.rx.tap.asDriver(),
            toSignUpTap: toSignUpButton.rx.tap.asDriver()
        )
        
        let output = viewModel.transform(input)
        
        output.findPasswordEnabled
            .drive(findPasswordButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        output.foundPassword
            .drive()
            .disposed(by: disposeBag)
        
        output.searchingPassword
            .drive(activityIndicator.rx.isAnimating)
            .disposed(by: disposeBag)
        
        output.toFindId
            .drive()
            .disposed(by: disposeBag)
        
        output.toLogin
            .drive()
            .disposed(by: disposeBag)
        
        output.toSignUp
            .drive()
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
        
        NotificationCenter.default.rx
            .notification(UIResponder.keyboardWillShowNotification)
            .filter { [weak self] _ in
                guard let self = self else {
                    return false
                }
                
                return self.view.frame.origin.y >= 0
            }
            .mapKeyboardHeight()
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] in
                guard let self = self else {
                    return
                }
                
                self.view.frame.origin.y -= $0
            })
            .disposed(by: disposeBag)
        
        NotificationCenter.default.rx
            .notification(UIResponder.keyboardWillHideNotification)
            .filter { [weak self] _ in
                guard let self = self else {
                    return false
                }
                
                return self.view.frame.origin.y < 0
            }
            .mapKeyboardHeight()
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] in
                guard let self = self else {
                    return
                }
                
                self.view.frame.origin.y += $0
            })
            .disposed(by: disposeBag)
    }
}

// MARK: - Configure UI
extension FindPasswordViewController {
    private func configureSubview() {
        [idTextField, emailTextField, findPasswordButton].forEach {
            idPasswordLoginStackView.addArrangedSubview($0)
        }
        
        idPasswordLoginStackView.setCustomSpacing(20, after: emailTextField)
        
        [toLoginButton,
         firstSeperateView,
         toFindIdButton,
         secondSeperateView,
         toSignUpButton
        ].forEach {
            toFindSignButtonStackView.addArrangedSubview($0)
        }
        
        [backgroundView, idPasswordLoginStackView, toFindSignButtonStackView, activityIndicator].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    private func configureLayout() {
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            // MARK: backgroundView Constraints
            backgroundView.topAnchor.constraint(
                equalTo: view.topAnchor
            ),
            backgroundView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor
            ),
            backgroundView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor
            ),
            backgroundView.bottomAnchor.constraint(
                equalTo: view.bottomAnchor
            ),
            
            // MARK: - idPasswordLoginStackView Constraints
            idPasswordLoginStackView.centerXAnchor.constraint(
                equalTo: safeArea.centerXAnchor
            ),
            idPasswordLoginStackView.centerYAnchor.constraint(
                equalTo: safeArea.centerYAnchor,
                constant: (view.bounds.height * 0.2)
            ),
            idPasswordLoginStackView.widthAnchor.constraint(
                equalTo: safeArea.widthAnchor,
                multiplier: 0.75
            ),
            
            // MARK: - loginButton Constraints
            findPasswordButton.heightAnchor.constraint(
                equalTo: safeArea.heightAnchor,
                multiplier: 0.06
            ),
            
            // MARK: - findSignButtonStackView Constraints
            toFindSignButtonStackView.topAnchor.constraint(
                equalTo: idPasswordLoginStackView.bottomAnchor,
                constant: 20
            ),
            toFindSignButtonStackView.centerXAnchor.constraint(
                equalTo: safeArea.centerXAnchor
            ),
            
            // MARK: - seperateView Constraints
            firstSeperateView.widthAnchor.constraint(
                equalToConstant: 1
            ),
            firstSeperateView.heightAnchor.constraint(
                equalTo: toFindIdButton.heightAnchor,
                multiplier: 0.5
            ),
            secondSeperateView.widthAnchor.constraint(
                equalToConstant: 1
            ),
            secondSeperateView.heightAnchor.constraint(
                equalTo: firstSeperateView.heightAnchor
            ),
            
            // MARK: - activityIndicator Constraints
            activityIndicator.centerXAnchor.constraint(
                equalTo: safeArea.centerXAnchor
            ),
            activityIndicator.centerYAnchor.constraint(
                equalTo: safeArea.centerYAnchor
            )
        ])
    }
}
