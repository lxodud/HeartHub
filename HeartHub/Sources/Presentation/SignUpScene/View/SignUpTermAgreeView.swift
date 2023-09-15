//
//  SignUp4View.swift
//  HeartHub
//
//  Created by 제민우 on 2023/07/11.
//

import UIKit

final class SignUpTermAgreeView: UIView {
    
    let unCheckedImg = UIImage(named: "AgreeRadioBtnUnChecked")
    
    private let signUpBackgroundView = SignUpBackgroundView(
        heartImage: "HeartIcon3:3",
        ourStartLabelText: "사랑을 시작해볼까요?",
        descriptionLabelText: "계정을 생성하여 HeartHuB를 즐겨보아요.")
    
    let signUpTermAgreePreviousPageButton = SignUpChangePageButton(buttonImage: "LeftArrow")
    
    let createAccountButton: UIButton = {
        let btn = UIButton(type: .custom)
        btn.backgroundColor = .white
        btn.layer.borderWidth = 1
        btn.layer.cornerRadius = 18
        btn.layer.borderColor = #colorLiteral(red: 0.9803773761, green: 0.1853338182, blue: 0.7394250631, alpha: 1)
 
        btn.setTitle("계정 생성하기", for: .normal)
        btn.titleLabel?.font = UIFont.init(name: "Pretendard-Regular", size: 14)
        btn.titleLabel?.textAlignment = .center
        btn.setTitleColor(UIColor(red: 0.067, green: 0.067, blue: 0.067, alpha: 1), for: .normal)
        btn.sizeToFit()
        btn.titleLabel?.adjustsFontSizeToFitWidth = true
        btn.titleLabel?.numberOfLines = 1
        
        btn.layer.shadowColor = UIColor(red: 0.98, green: 0.184, blue: 0.741, alpha: 0.25).cgColor
        btn.layer.shadowOpacity = 1.0
        btn.layer.shadowOffset = CGSize(width: 0, height: 4)
        btn.layer.shadowRadius = 6
        
        return btn
        
    }()
    

    // MARK: 뷰 초기화
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        configureSubViews()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SignUpTermAgreeView {
    func configureSubViews() {
        [signUpBackgroundView,
         signUpTermAgreePreviousPageButton,
         createAccountButton
        ].forEach {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    // MARK: 제약
    private func configureLayout() {
        let safeArea = safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            // MARK: signUpBackgroundView Constraints
            signUpBackgroundView.centerXAnchor.constraint(equalTo: centerXAnchor),
            signUpBackgroundView.centerYAnchor.constraint(equalTo: centerYAnchor),
            signUpBackgroundView.topAnchor.constraint(equalTo: topAnchor),
            signUpBackgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            
            // MARK: changePageButton Constraints
            signUpTermAgreePreviousPageButton.heightAnchor.constraint(equalTo: signUpTermAgreePreviousPageButton.widthAnchor),
            signUpTermAgreePreviousPageButton.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -33),
            signUpTermAgreePreviousPageButton.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 40),
            signUpTermAgreePreviousPageButton.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -33),

            
            createAccountButton.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.066),
            createAccountButton.topAnchor.constraint(equalTo: signUpTermAgreePreviousPageButton.topAnchor),
            createAccountButton.leadingAnchor.constraint(equalTo: signUpTermAgreePreviousPageButton.trailingAnchor, constant: 113),
            createAccountButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -40)

        ])
    }
}
