//
//  LoginViewController.swift
//  HeartHub
//
//  Created by 이태영 on 2023/09/15.
//

import UIKit

final class LoginViewController: UIViewController {
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
        button.backgroundColor = .white
        button.layer.cornerRadius = 8
        button.layer.borderWidth = 1
        button.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        button.setTitle("로그인", for: .normal)
        button.titleLabel?.font = UIFont.init(name: "Pretendard-SemiBold", size: 16)
        button.setTitleColor(UIColor(red: 0.98, green: 0.18, blue: 0.74, alpha: 1), for: .normal)
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
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSubview()
        configureLayout()
        view.backgroundColor = .red
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
        
        [backgroundView,idPasswordLoginStackView, findSignButtonStackView].forEach {
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
            )
        ])
    }
}
