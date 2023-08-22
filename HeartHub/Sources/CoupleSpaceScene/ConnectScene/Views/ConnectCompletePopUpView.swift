//
//  ConnectCompletePopUpView.swift
//  HeartHub
//
//  Created by 제민우 on 2023/08/15.
//

import UIKit

final class ConnectCompletePopUpView: UIView {

    // MARK: 레이블
    private let completeConnectLabel: UILabel = {
        let label = UILabel()
        label.text = "계정 연동 완료!"
        label.textAlignment = .center
        label.font = UIFont(name: "Pretendard-SemiBold", size: 24)
        label.textColor = .black
        return label
    }()
    
    // 종이비행기 이미지뷰
    private let connectCheckImage: UIImageView = {
        var imgView = UIImageView()
        imgView.contentMode = .scaleAspectFit
        imgView.image = UIImage(named: "ReportCheck")
        imgView.clipsToBounds = true
        return imgView
    }()
   
    // MARK: 닫기버튼
    var connectCompleteCloseButton: UIButton = {
        let btn = UIButton(type: .custom)
        btn.backgroundColor = .white
        btn.layer.borderWidth = 1
        btn.layer.borderColor = #colorLiteral(red: 0.9803773761, green: 0.1853338182, blue: 0.7394250631, alpha: 1)
        
        btn.setTitle("닫기", for: .normal)
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
        connectCompleteCloseButton.layer.cornerRadius = connectCompleteCloseButton.frame.height / 1.6
    }
}

// MARK: Configure Layout
extension ConnectCompletePopUpView {
    private func configureSubviews() {
        [completeConnectLabel,
         connectCheckImage,
         connectCompleteCloseButton].forEach {
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
            completeConnectLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            completeConnectLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 60),
            completeConnectLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 48),
            
            // MARK: loverProfileImage Constraints
            connectCheckImage.widthAnchor.constraint(equalTo: connectCheckImage.heightAnchor),
            connectCheckImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            connectCheckImage.topAnchor.constraint(equalTo: completeConnectLabel.bottomAnchor, constant: 37),
            connectCheckImage.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 87),
            
            // MARK: connectCompleteCloseButton Constraints
            connectCompleteCloseButton.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 0.09),
            connectCompleteCloseButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            connectCompleteCloseButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -40),
            connectCompleteCloseButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 30)
        ])
    }
}
