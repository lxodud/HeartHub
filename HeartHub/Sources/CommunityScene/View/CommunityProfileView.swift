//
//  CommunityProfileView.swift
//  HeartHub
//
//  Created by 이태영 on 2023/07/10.
//

import UIKit

final class CommunityProfileView: UIStackView {
    weak var delegate: CommunityProfileViewDelegate?
    
    let profileImageView: UIImageView = {
        let imageView = HeartHubProfileImageView()
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let profileIDLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        label.font = UIFont(name: "Pretendard-SemiBold", size: 16)
        return label
    }()
    
    init() {
        super.init(frame: .zero)
        configureInitialSetting()
        configureSubview()
        configureLayout()
        configureAction()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Public Interface
extension CommunityProfileView {
    func configureContents(_ username: String, _ profileImage: UIImage) {
        profileImageView.image = profileImage
        profileIDLabel.text = username
    }
    
    var labelLeadingAnchor: NSLayoutXAxisAnchor {
        return profileIDLabel.leadingAnchor
    }
}

// MARK: Configure Action
extension CommunityProfileView {
    private func configureAction() {
        let tapGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(tapUserProfile)
        )
        profileImageView.addGestureRecognizer(tapGesture)
        profileIDLabel.addGestureRecognizer(tapGesture)
    }
    
    @objc
    private func tapUserProfile() {
        delegate?.didTapUserProfile()
    }
}

// MARK: Configure UI
extension CommunityProfileView {
    private func configureInitialSetting() {
        axis = .horizontal
        alignment = .center
        distribution = .fill
        spacing = 15
    }
    
    private func configureSubview() {
        [profileImageView, profileIDLabel].forEach {
            addArrangedSubview($0)
        }
        
        profileIDLabel.setContentHuggingPriority(.required, for: .horizontal)
    }
    
    private func configureLayout() {
        NSLayoutConstraint.activate([
            // MARK: profileImageView Constraint
            profileImageView.widthAnchor.constraint(
                equalTo: profileImageView.heightAnchor
            ),
            profileImageView.heightAnchor.constraint(
                equalTo: safeAreaLayoutGuide.heightAnchor,
                multiplier: 0.5
            )
        ])
    }
}
