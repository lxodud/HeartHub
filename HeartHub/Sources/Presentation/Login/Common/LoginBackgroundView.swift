//
//  LoginBackgroundView.swift
//  HeartHub
//
//  Created by 제민우 on 2023/08/06.
//

import UIKit

final class LoginBackgroundView: UIView {
    private let backgroundView: UIImageView = {
        var imgView = UIImageView()
        imgView.contentMode = .scaleAspectFill
        imgView.image = UIImage(named: "BackgroundGradient.png")
        return imgView
    }()
    
    private let mountainBackgroundView: UIImageView = {
        var imgView = UIImageView()
        imgView.contentMode = .scaleAspectFill
        imgView.image = UIImage(named: "MountainBackground.png")
        return imgView
    }()
    
    private let loginMountainFrontView: UIImageView = {
        var imgView = UIImageView()
        imgView.contentMode = .scaleAspectFill
        imgView.image = UIImage(named: "LoginMountainFront.png")
        return imgView
    }()
    
    private let heartImageView: UIImageView = {
        var imgView = UIImageView()
        imgView.contentMode = .scaleAspectFit
        imgView.image = UIImage(named: "HeartBrand.png")
        return imgView
    }()
    
    private let heartHubMainLabelImageView: UIImageView = {
        var imgView = UIImageView()
        imgView.contentMode = .scaleAspectFit
        imgView.image = UIImage(named: "HeartHubMainLabel")
        return imgView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureSubView()
        configureLayout()
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Configure UI
extension LoginBackgroundView {
    private func configureSubView() {
        [backgroundView,
         mountainBackgroundView,
         loginMountainFrontView,
         heartHubMainLabelImageView,
         heartImageView
         ].forEach {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    private func configureLayout() {
        NSLayoutConstraint.activate([
            // MARK: - backgroundView Constraints
            backgroundView.topAnchor.constraint(
                equalTo: topAnchor
            ),
            backgroundView.leadingAnchor.constraint(
                equalTo: leadingAnchor
            ),
            backgroundView.trailingAnchor.constraint(
                equalTo: trailingAnchor
            ),
            backgroundView.bottomAnchor.constraint(
                equalTo: bottomAnchor
            ),
            
            // MARK: - mountainBackgroundView Constraints
            mountainBackgroundView.leadingAnchor.constraint(
                equalTo: leadingAnchor
            ),
            mountainBackgroundView.trailingAnchor.constraint(
                equalTo: trailingAnchor
            ),
            mountainBackgroundView.bottomAnchor.constraint(
                equalTo: bottomAnchor
            ),
            
            // MARK: loginMountainFrontView Constraints
            loginMountainFrontView.leadingAnchor.constraint(
                equalTo: leadingAnchor
            ),
            loginMountainFrontView.trailingAnchor.constraint(
                equalTo: trailingAnchor
            ),
            loginMountainFrontView.bottomAnchor.constraint(
                equalTo: bottomAnchor
            ),
            
            // MARK: - heartImageView Constraints
            heartImageView.centerYAnchor.constraint(
                equalTo: centerYAnchor
            ),
            heartImageView.centerXAnchor.constraint(
                equalTo: centerXAnchor
            ),
            
            // MARK: - heartHubMainLabelImageView Constraints
            heartHubMainLabelImageView.centerXAnchor.constraint(
                equalTo: centerXAnchor
            ),
            heartHubMainLabelImageView.bottomAnchor.constraint(
                equalTo: heartImageView.topAnchor,
                constant: -30
            ),
        ])
    }
}
