//
//  LoginBackGroundView.swift
//  HeartHub
//
//  Created by 제민우 on 2023/08/06.
//

import UIKit

final class LoginBackGroundView: UIView {

    private let backgroundView: UIImageView = {
        var imgView = UIImageView()
        imgView.contentMode = .scaleAspectFit
        imgView.image = UIImage(named: "BackgroundGradient.png")
        return imgView
    }()
    
    private let mountainBackgroundView: UIImageView = {
        var imgView = UIImageView()
        imgView.contentMode = .scaleAspectFit
        imgView.image = UIImage(named: "MountainBackground.png")
        return imgView
    }()
    
    // 산이미지 앞에 gradient
    private let LoginMountainFrontView: UIImageView = {
        var imgView = UIImageView()
        imgView.contentMode = .scaleAspectFit
        imgView.image = UIImage(named: "LoginMountainFront.png")
        return imgView
    }()
    
    // 메인하트 이미지
    private let heartImageView: UIImageView = {
        var imgView = UIImageView()
        imgView.contentMode = .scaleAspectFit
        imgView.image = UIImage(named: "HeartBrand.png")
        return imgView
    }()
    
    // MARK: HeartHub main Label Image
    private let HeartHubMainLabelImageView: UIImageView = {
        var imgView = UIImageView()
        imgView.contentMode = .scaleAspectFit
        imgView.image = UIImage(named: "HeartHubMainLabel")
        return imgView
    }()
    
    // MARK: 뷰 초기화
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureSubView()
        configureLayout()
        
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

// MARK: Configure Layout
extension LoginBackGroundView {
    private func configureSubView() {
        [backgroundView,
         mountainBackgroundView,
         LoginMountainFrontView,
         HeartHubMainLabelImageView,
         heartImageView
         ].forEach {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    private func configureLayout() {
        NSLayoutConstraint.activate([
            // MARK: BackgroundView Constraints
            backgroundView.centerXAnchor.constraint(equalTo: centerXAnchor),
            backgroundView.centerYAnchor.constraint(equalTo: centerYAnchor),
            backgroundView.topAnchor.constraint(equalTo: topAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            
            // MARK: mountainBackgroundView Constraints
            mountainBackgroundView.topAnchor.constraint(equalTo: topAnchor, constant: 558),
            mountainBackgroundView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 6),
            mountainBackgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            mountainBackgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            // MARK: LoginMountainFrontView Constraints
            LoginMountainFrontView.topAnchor.constraint(equalTo: topAnchor, constant: 422),
            LoginMountainFrontView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 10),
            LoginMountainFrontView.leadingAnchor.constraint(equalTo: leadingAnchor),
            LoginMountainFrontView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            // MARK: HeartHubMainLabelImageView Constraints
            HeartHubMainLabelImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            HeartHubMainLabelImageView.topAnchor.constraint(equalTo: topAnchor, constant: 261),
            
            // MARK: LoginMountainFrontView Constraints
            heartImageView.topAnchor.constraint(equalTo: HeartHubMainLabelImageView.bottomAnchor, constant: 33),
            heartImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])
    }
}
