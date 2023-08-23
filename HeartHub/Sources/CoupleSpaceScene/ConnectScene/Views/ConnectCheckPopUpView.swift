//
//  ConnectCheckPopUpView.swift
//  HeartHub
//
//  Created by 제민우 on 2023/08/15.
//

import UIKit

final class ConnectCheckPopUpView: UIView {
    
    // MARK: 레이블
    private let connectLoverLabel: UILabel = {
        let label = UILabel()
        label.text = "내 애인의 계정이 맞나요?"
        label.numberOfLines = 1
        label.textAlignment = .center
        label.font = UIFont(name: "Pretendard-SemiBold", size: 24)
        label.textColor = .black
        return label
    }()
    
    // 종이비행기 이미지뷰
    private let loverProfileImage: UIImageView = {
        var imgView = UIImageView()
        imgView.contentMode = .scaleAspectFit
        imgView.image = UIImage(named: "TestImage")
        imgView.clipsToBounds = true
        return imgView
    }()
    
    private let loverNickNameLabel: UILabel = {
        let label = UILabel()
        label.text = "우리자기 사랑행"
        label.numberOfLines = 1
        label.textAlignment = .center
        label.font = UIFont(name: "Pretendard-Regular", size: 14)
        label.textColor = .black
        return label
    }()
    
    // MARK: 닫기버튼
    var connectPopUpCorrectButton: UIButton = {
        let btn = UIButton(type: .custom)
        btn.backgroundColor = .white
        btn.layer.borderWidth = 1
        btn.layer.cornerRadius = 18
        btn.layer.borderColor = #colorLiteral(red: 0.9803773761, green: 0.1853338182, blue: 0.7394250631, alpha: 1)
        
        btn.setTitle("맞아요!", for: .normal)
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
    
    var connectPopUpReFindButton: UIButton = {
        let btn = UIButton(type: .custom)
        btn.backgroundColor = .white
        btn.layer.borderWidth = 1
        btn.layer.cornerRadius = 18
        btn.layer.borderColor = #colorLiteral(red: 0.9803773761, green: 0.1853338182, blue: 0.7394250631, alpha: 1)
        
        btn.setTitle("재검색", for: .normal)
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
    
    private lazy var connectPopUpButtonStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [connectPopUpCorrectButton, connectPopUpReFindButton])
        stackView.axis = .horizontal
        stackView.spacing = 42
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    
    private var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.clipsToBounds = true
        view.layer.cornerRadius = 18
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(red: 0.067, green: 0.067, blue: 0.067, alpha: 0.2)
        configureSubviews()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        loverProfileImage.layer.cornerRadius = loverProfileImage.frame.height / 2
        connectPopUpCorrectButton.layer.cornerRadius = connectPopUpCorrectButton.frame.height / 2
        connectPopUpReFindButton.layer.cornerRadius = connectPopUpReFindButton.frame.height / 2

    }
}

// MARK: Configure Layout
extension ConnectCheckPopUpView {
    private func configureSubviews() {
        [connectLoverLabel,
         loverProfileImage,
         loverNickNameLabel,
         connectPopUpButtonStackView].forEach {
            containerView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        [containerView].forEach {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false }
    }
    
    private func configureLayout() {
        
        let safeArea = safeAreaLayoutGuide

        NSLayoutConstraint.activate([
            // MARK: containerView Constraints
            containerView.centerXAnchor.constraint(equalTo: centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: centerYAnchor),
            containerView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 177),
            containerView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 30),

            // MARK: connectLoverLabel Constraints
            connectLoverLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            connectLoverLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 60),
            connectLoverLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            
            // MARK: loverProfileImage Constraints
            loverProfileImage.widthAnchor.constraint(equalTo: loverProfileImage.heightAnchor),
            loverProfileImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            loverProfileImage.topAnchor.constraint(equalTo: connectLoverLabel.bottomAnchor, constant: 33),
            loverProfileImage.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 109),
            
            // MARK: loverNickNameLabel Constraints
            loverNickNameLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            loverNickNameLabel.topAnchor.constraint(equalTo: loverProfileImage.bottomAnchor, constant: 12),
            loverNickNameLabel.leadingAnchor.constraint(equalTo: loverProfileImage.leadingAnchor),

            // MARK: connectPopUpButtonStackView Constraints
            connectPopUpButtonStackView.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 0.09),
            connectPopUpButtonStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            connectPopUpButtonStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -48),
            connectPopUpButtonStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 56)
        ])
    }
}
