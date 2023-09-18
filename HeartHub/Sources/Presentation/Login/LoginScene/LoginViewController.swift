//
//  LoginViewController.swift
//  HeartHub
//
//  Created by 이태영 on 2023/09/15.
//

import RxCocoa
import RxSwift
import UIKit

final class LoginViewController: UIViewController {
    private let loginViewModel: LoginViewModel
    private let disposeBag = DisposeBag()
    
    private let backgroundView = LoginBackGroundView()
    private let idTextField = LoginTextField(
        placeholder: "아이디를 입력하세요",
        keyboardType: .default,
        isSecureTextEntry: false
    )
    
    private let passwordTextField = LoginTextField(
        placeholder: "비밀번호를 입력하세요",
        keyboardType: .default,
        isSecureTextEntry: true
    )
    
    private let loginButton: UIButton = {
        let button = UIButton(type: .custom)
        button.layer.cornerRadius = 8
        button.clipsToBounds = true
        button.setTitle("로그인", for: .normal)
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
    
    private let findIdButton: UIButton = {
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
    
    private let signUpButton: UIButton = {
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
    
    private let findPasswordButton: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = .clear
        button.setTitle("비밀번호 찾기", for: .normal)
        button.titleLabel?.textAlignment = .center
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.init(name: "Pretendard-Regular", size: 16)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.titleLabel?.numberOfLines = 1
        return button
    }()
    
    private let findSignButtonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fillProportionally
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
    
    private let activityIndicator = UIActivityIndicatorView()
    
    init(loginViewModel: LoginViewModel) {
        self.loginViewModel = loginViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSubview()
        configureLayout()
        bind(to: loginViewModel)
        bindUI()
    }
    
    private func bind(to: LoginViewModel) {
        let input = LoginViewModel.Input(
            id: idTextField.rx.text.orEmpty.asDriver(),
            password: passwordTextField.rx.text.orEmpty.asDriver(),
            loginTap: loginButton.rx.tap.asDriver(),
            findIdTap: findIdButton.rx.tap.asDriver(),
            findPasswordTap: findPasswordButton.rx.tap.asDriver(),
            signUpTap: signUpButton.rx.tap.asDriver()
        )
        
        let output = loginViewModel.transform(input)
        
        output.loginEnabled
            .drive(loginButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        output.findId
            .drive()
            .disposed(by: disposeBag)
        
        output.findPassword
            .drive()
            .disposed(by: disposeBag)
        
        output.signUp
            .drive()
            .disposed(by: disposeBag)
        
        output.loginIn
            .do(onNext: { _ in self.view.endEditing(true) })
            .drive(activityIndicator.rx.isAnimating)
            .disposed(by: disposeBag)
                
        output.loginIn
            .drive(with: self, onNext: {
                self.loginButton.isEnabled = !$1
            })
            .disposed(by: disposeBag)
                
        output.logedIn
            .filter({ $0 == false })
            .do(onNext: { _ in self.showAlert() })
            .drive()
            .disposed(by: disposeBag)
        }

    private func bindUI() {
        let tapBackground = UITapGestureRecognizer()
        view.addGestureRecognizer(tapBackground)
        tapBackground.rx.event
            .withUnretained(self)
            .subscribe(onNext: { _ in
                self.view.endEditing(true)
            })
            .disposed(by: disposeBag)
        
        NotificationCenter.default.rx
            .notification(UIResponder.keyboardWillShowNotification)
            .filter({ _ in self.view.frame.origin.y >= 0 })
            .compactMap({ $0.userInfo as? NSDictionary })
            .compactMap({ $0.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as? NSValue})
            .compactMap({ $0.cgRectValue.height })
            .observe(on: MainScheduler.instance)
            .withUnretained(self)
            .subscribe(onNext: {
                self.view.frame.origin.y -= $0.1
            })
            .disposed(by: disposeBag)
        
        NotificationCenter.default.rx
            .notification(UIResponder.keyboardWillHideNotification)
            .filter({ _ in self.view.frame.origin.y < 0 })
            .compactMap({ $0.userInfo as? NSDictionary })
            .compactMap({ $0.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as? NSValue})
            .compactMap({ $0.cgRectValue.height })
            .observe(on: MainScheduler.instance)
            .withUnretained(self)
            .subscribe(onNext: {
                self.view.frame.origin.y += $0.1
            })
            .disposed(by: disposeBag)
    }
    
    private func showAlert() {
        let alert = UIAlertController(title: "로그인 실패", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "확인", style: .default) { _ in
            self.dismiss(animated: true)
        }
        alert.addAction(action)
        self.present(alert, animated: true)
    }
}

// MARK: - Configure UI
extension LoginViewController {
    private func configureSubview() {
        [idTextField, passwordTextField, loginButton].forEach {
            idPasswordLoginStackView.addArrangedSubview($0)
        }
        
        idPasswordLoginStackView.setCustomSpacing(20, after: passwordTextField)
        
        [findIdButton,
         firstSeperateView,
         signUpButton,
         secondSeperateView,
         findPasswordButton].forEach {
            findSignButtonStackView.addArrangedSubview($0)
        }
        
        [backgroundView,idPasswordLoginStackView, findSignButtonStackView, activityIndicator].forEach {
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
            
            // MARK: - findSignButtonStackView Constraints
            findSignButtonStackView.topAnchor.constraint(
                equalTo: idPasswordLoginStackView.bottomAnchor,
                constant: 20
            ),
            findSignButtonStackView.centerXAnchor.constraint(
                equalTo: safeArea.centerXAnchor
            ),
            findSignButtonStackView.widthAnchor.constraint(
                equalTo: safeArea.widthAnchor,
                multiplier: 0.7
            ),
            
            // MARK: - seperateView Constraints
            firstSeperateView.widthAnchor.constraint(
                equalToConstant: 1
            ),
            firstSeperateView.heightAnchor.constraint(
                equalTo: findIdButton.heightAnchor,
                multiplier: 0.5
            ),
            secondSeperateView.widthAnchor.constraint(
                equalToConstant: 1
            ),
            secondSeperateView.heightAnchor.constraint(
                equalTo: firstSeperateView.heightAnchor
            ),
            
            loginButton.heightAnchor.constraint(
                equalTo: safeArea.heightAnchor,
                multiplier: 0.06
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
