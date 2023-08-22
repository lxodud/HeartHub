//
//  CommentCellHeaderView.swift
//  HeartHub
//
//  Created by 이태영 on 2023/07/25.
//

import UIKit

final class CommentCellHeaderView: UIView {
    weak var delegate: CommentCellHeaderViewDelegate?
    
    private let profileView = CommunityProfileView()
    private let postTimeLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private let heartCountLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private let heartButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "HeartHubEmptyHeart"), for: .normal)
        button.setImage(UIImage(named: "HeartHubFillHeart"), for: .selected)
        return button
    }()
    
    init() {
        super.init(frame: .zero)
        configureSubview()
        configureLayout()
        configureAction()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Public Interface
extension CommentCellHeaderView {
    func configureProfile(_ data: (authorname: String, image: UIImage)) {
        profileView.profileIDLabel.text = data.authorname
        profileView.profileImageView.image = data.image
    }
    
    func configureHeartInformation(_ data: (isSelected: Bool, count: String)) {
        heartButton.isSelected = data.isSelected
        heartCountLabel.text = data.count
    }
    
    var idLabelLeadingAnchor: NSLayoutXAxisAnchor {
        return profileView.labelLeadingAnchor
    }
    
    var heartButtonLeadingAnchor: NSLayoutXAxisAnchor {
        return heartButton.leadingAnchor
    }
}

// MARK: Community ProfileView Implementation
extension CommentCellHeaderView: CommunityProfileViewDelegate {
    func didTapUserProfile() {
        delegate?.didTapUserProfile()
    }
}

// MARK: Configure Action
extension CommentCellHeaderView {
    private func configureAction() {
        heartButton.addTarget(
            self,
            action: #selector(tapHeartButton(_:)),
            for: .touchUpInside
        )
    }
    
    @objc
    private func tapHeartButton(_ sender: UIButton) {
        sender.isSelected.toggle()
        delegate?.didTapHeartButton()
    }
}

// MARK: Configure UI
extension CommentCellHeaderView {
    private func configureSubview() {
        [profileView, postTimeLabel, heartCountLabel, heartButton].forEach {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        profileView.delegate = self
        
        postTimeLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
        heartButton.setContentHuggingPriority(.required, for: .horizontal)
        profileView.setContentHuggingPriority(.required, for: .horizontal)
        heartCountLabel.setContentHuggingPriority(.required, for: .horizontal)
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
            
            // MARK: postTimeLabel Constraint
            postTimeLabel.topAnchor.constraint(
                equalTo: safeArea.topAnchor
            ),
            postTimeLabel.leadingAnchor.constraint(
                equalTo: profileView.trailingAnchor,
                constant: 15
            ),
            postTimeLabel.bottomAnchor.constraint(
                equalTo: safeArea.bottomAnchor
            ),
            postTimeLabel.trailingAnchor.constraint(equalTo: heartCountLabel.leadingAnchor),

            // MARK: heartCountLabel Constraint
            heartCountLabel.topAnchor.constraint(
                equalTo: safeArea.topAnchor
            ),
            heartCountLabel.trailingAnchor.constraint(
                equalTo: heartButton.leadingAnchor,
                constant: -5
            ),
            heartCountLabel.bottomAnchor.constraint(
                equalTo: safeArea.bottomAnchor
            ),
            
            // MARK: heartButton Constraint
            heartButton.topAnchor.constraint(
                equalTo: safeArea.topAnchor
            ),
            heartButton.trailingAnchor.constraint(
                equalTo: safeArea.trailingAnchor
            ),
            heartButton.bottomAnchor.constraint(
                equalTo: safeArea.bottomAnchor
            ),
        ])
    }
}
