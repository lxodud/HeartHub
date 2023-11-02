//
//  CoupleImageBetweenHeartView.swift
//  HeartHub
//
//  Created by 이태영 on 2023/07/31.
//

import UIKit

final class CoupleImageBetweenHeartView: UIView {
    private let myProfileImageView = HeartHubProfileImageView()
    private let partnerProfileImageView = HeartHubProfileImageView()
    
    private let heartImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "HeartIcon0:3")
        return imageView
    }()
    
    init() {
        super.init(frame: .zero)
        configureSubview()
        configureLayout()
        myProfileImageView.image = UIImage(named: "MountainBackground")
        partnerProfileImageView.image = UIImage(named: "MountainBackground")
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Configure UI
extension CoupleImageBetweenHeartView {
    private func configureSubview() {
        [myProfileImageView, heartImageView, partnerProfileImageView].forEach {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    private func configureLayout() {
        let safeArea = safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            // MARK: myProfileImageView Constraint
            myProfileImageView.heightAnchor.constraint(
                equalTo: safeArea.heightAnchor,
                multiplier: 0.5
            ),
            myProfileImageView.widthAnchor.constraint(
                equalTo: myProfileImageView.heightAnchor
            ),
            myProfileImageView.trailingAnchor.constraint(
                equalTo: heartImageView.leadingAnchor,
                constant: -15
            ),
            myProfileImageView.centerYAnchor.constraint(
                equalTo: safeArea.centerYAnchor
            ),
            
            // MARK: partnerProfileImageView Constraint
            partnerProfileImageView.heightAnchor.constraint(
                equalTo: myProfileImageView.heightAnchor
            ),
            partnerProfileImageView.widthAnchor.constraint(
                equalTo: partnerProfileImageView.heightAnchor
            ),
            partnerProfileImageView.leadingAnchor.constraint(
                equalTo: heartImageView.trailingAnchor,
                constant: 15
            ),
            partnerProfileImageView.centerYAnchor.constraint(
                equalTo: safeArea.centerYAnchor
            ),
            
            // MARK: heartImageView Constraint
            heartImageView.heightAnchor.constraint(
                equalTo: partnerProfileImageView.heightAnchor,
                multiplier: 0.5
            ),
            heartImageView.widthAnchor.constraint(
                equalTo: heartImageView.heightAnchor
            ),
            heartImageView.centerYAnchor.constraint(
                equalTo: safeArea.centerYAnchor
            ),
            heartImageView.centerXAnchor.constraint(
                equalTo: safeArea.centerXAnchor
            ),
        ])
    }
}
