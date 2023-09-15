//
//  LoginSelectPageButtonStackView.swift
//  HeartHub
//
//  Created by 제민우 on 2023/08/11.
//

import UIKit

class LoginSelectPageButtonStackView: UIStackView {

        var leftSelectPageButton: UIButton = {
            let button = UIButton(type: .custom)
            button.backgroundColor = .clear
            button.titleLabel?.textAlignment = .center
            button.setTitleColor(UIColor.white, for: .normal)
            button.titleLabel?.font = UIFont.init(name: "Pretendard-Regular", size: 16)
            button.sizeToFit()
            button.titleLabel?.adjustsFontSizeToFitWidth = true
            button.titleLabel?.numberOfLines = 1
            return button
        }()
        
        // 회원가입 버튼
        var middleSelectPageButton: UIButton = {
            let button = UIButton(type: .custom)
            button.backgroundColor = .clear
            button.titleLabel?.textAlignment = .center
            button.setTitleColor(UIColor.white, for: .normal)
            button.titleLabel?.font = UIFont.init(name: "Pretendard-Regular", size: 16)
            button.sizeToFit()
            button.titleLabel?.adjustsFontSizeToFitWidth = true
            button.titleLabel?.numberOfLines = 1
            return button
        }()
        
        // 비밀번호 찾기 버튼
        var rightSelectPageButton: UIButton = {
            let button = UIButton(type: .custom)
            button.backgroundColor = .clear
            button.titleLabel?.textAlignment = .center
            button.setTitleColor(UIColor.white, for: .normal)
            button.titleLabel?.font = UIFont.init(name: "Pretendard-Regular", size: 16)
            button.sizeToFit()
            button.titleLabel?.adjustsFontSizeToFitWidth = true
            button.titleLabel?.numberOfLines = 1
            return button
        }()
        
        private var lineView1: UIView = {
            let view = UIView()
            view.backgroundColor = #colorLiteral(red: 1, green: 0.9999999404, blue: 1, alpha: 1)
            return view
        }()
        
        private var lineView2: UIView = {
            let view = UIView()
            view.backgroundColor = #colorLiteral(red: 1, green: 0.9999999404, blue: 1, alpha: 1)
            return view
        }()
        
        lazy var signUpFindIdPwStackView: UIStackView = {
            let stView = UIStackView(arrangedSubviews: [leftSelectPageButton, lineView1, middleSelectPageButton, lineView2, rightSelectPageButton])
            stView.spacing = 10
            stView.axis = .horizontal
            stView.distribution = .fillProportionally
            stView.alignment = .center
            return stView
        }()
        
    init(leftTitle: String, middleTitle: String, rightTitle: String, stackViewDistribution: Distribution) {
        super.init(frame: .zero)
        
        leftSelectPageButton.setTitle(leftTitle, for: .normal)
        middleSelectPageButton.setTitle(middleTitle, for: .normal)
        rightSelectPageButton.setTitle(rightTitle, for: .normal)
        distribution = stackViewDistribution
        
        configureInitialSetting()
        configureSubviews()
        configureLayout()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension LoginSelectPageButtonStackView {
    private func configureInitialSetting() {
        spacing = 10
        axis = .horizontal
        alignment = .center
    }
    
    private func configureSubviews(){
        [leftSelectPageButton, lineView1, middleSelectPageButton, lineView2, rightSelectPageButton].forEach {
            addArrangedSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    private func configureLayout() {
        
    }
}
