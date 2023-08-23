//
//  MyPageLogoutAlert.swift
//  HeartHub
//
//  Created by 제민우 on 2023/08/23.
//

import UIKit

class MyPageLogoutAlertView: UIView {
    
    private lazy var userNickNameLabel: UILabel = {
        let label = UILabel()
        label.text = "로그아웃 하시겠습니까??"
        label.textAlignment = .center
        label.font = UIFont(name: "Pretendard-SemiBold", size: 24)
        label.adjustsFontForContentSizeCategory = true
        label.textColor = .black
        return label
    }()
    
    var logoutCancelButton = AlertButton(buttonColor: .white, borderColor: #colorLiteral(red: 0.9803773761, green: 0.1853338182, blue: 0.7394250631, alpha: 1), title: "취소", titleColor: .black)
    var logoutVerifyButton = AlertButton(buttonColor: .white, borderColor: #colorLiteral(red: 0.9803773761, green: 0.1853338182, blue: 0.7394250631, alpha: 1), title: "확인", titleColor: .black)
    
    private lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [logoutCancelButton, logoutVerifyButton])
        stackView.axis = .horizontal
        stackView.spacing = 42
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.clipsToBounds = true
        view.layer.cornerRadius = 18
        return view
    }()
    
    // MARK: 뷰 초기화
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(red: 0.067, green: 0.067, blue: 0.067, alpha: 0.2)
        configureSubviews()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MyPageLogoutAlertView {

    // MARK: 제약
    private func configureSubviews() {
        [userNickNameLabel, buttonStackView].forEach {
            containerView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
    }

    private func configureConstraints() {
        
        let safeArea = safeAreaLayoutGuide

        NSLayoutConstraint.activate([
            containerView.centerXAnchor.constraint(equalTo: centerXAnchor),
            containerView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 244),
            containerView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -252),
            containerView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 30),

            userNickNameLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            userNickNameLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 60),
            userNickNameLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),

            buttonStackView.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 0.133),
            buttonStackView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            buttonStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -48),
            buttonStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 55),
        ])
    }
}
