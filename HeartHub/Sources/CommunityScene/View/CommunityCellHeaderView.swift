//
//  CommunityCellHeaderView.swift
//  HeartHub
//
//  Created by 이태영 on 2023/07/25.
//

import UIKit

final class CommunityCellHeaderView: UIView {
    weak var delegate: CommunityCellHeaderViewDelegate?
    
    private let profileView = CommunityProfileView()
    private let postOptionButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "ellipsis"), for: .normal)
        return button
    }()
    
    init() {
        super.init(frame: .zero)
        configureSubview()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Public Interface
extension CommunityCellHeaderView {
    func configureContents(_ data: (username: String, image: UIImage)) {
        profileView.profileIDLabel.text = data.username
        profileView.profileImageView.image = data.image
    }
}

// MARK: Community Profile View Delegate Implementation
extension CommunityCellHeaderView: CommunityProfileViewDelegate {
    func didTapUserProfile() {
        delegate?.didTapUserProfile()
    }
}

// MARK: Configure Action
extension CommunityCellHeaderView {
    private func configureAction() {
        postOptionButton.addTarget(
            self,
            action: #selector(tapPostOptionButton),
            for: .touchUpInside
        )
    }
    
    @objc
    private func tapPostOptionButton() {
        delegate?.didTapPostOptionButton()
    }
}

// MARK: Configure UI
extension CommunityCellHeaderView {
    private func configureSubview() {
        [profileView, postOptionButton].forEach {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    private func configureLayout() {
        let safeArea = safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            // MARK: profileView Constraint
            profileView.topAnchor.constraint(
                equalTo: safeArea.topAnchor
            ),
            profileView.leadingAnchor.constraint(
                equalTo: safeArea.leadingAnchor
            ),
            profileView.bottomAnchor.constraint(
                equalTo: safeArea.bottomAnchor
            ),
            
            // MARK: postOptionButton Constraint
            postOptionButton.topAnchor.constraint(
                equalTo: safeArea.topAnchor
            ),
            postOptionButton.trailingAnchor.constraint(
                equalTo: safeArea.trailingAnchor
            ),
            postOptionButton.bottomAnchor.constraint(
                equalTo: safeArea.bottomAnchor
            )
        ])
    }
}
