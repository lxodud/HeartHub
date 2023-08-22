//
//  CommentCell.swift
//  HeartHub
//
//  Created by 이태영 on 2023/07/25.
//

import UIKit

protocol CommentCellTransitionDelegate: AnyObject {
    func didTapUserProfile()
}

final class CommentCell: UITableViewCell {
    weak var transitionDelegate: CommentCellTransitionDelegate?
    var commentCellDataSource: CommentCellDataSource? {
        didSet {
            bind(to: commentCellDataSource)
            commentCellDataSource?.fetchCellContents()
        }
    }
    
    private let headerView = CommentCellHeaderView()
    let commentLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private let leaveCommentButton: UIButton = {
        let button = UIButton()
        button.setTitle("답글달기", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 10)
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureSubview()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(to dataSource: CommentCellDataSource?) {
        dataSource?.authorProfileInformationPublisher = { [weak self] username, imageData in
            var authorProfile: (String, UIImage) = (username, UIImage())
            
            if let imageData = imageData,
               let image = UIImage(data: imageData)
            {
                authorProfile.1 = image
            } else {
                authorProfile.1 = UIImage(named: "basicProfileImage")!
            }
            
            self?.headerView.configureProfile(authorProfile)
        }
        
        dataSource?.heartInformationPublisher = { [weak self] isGood, count in
            self?.headerView.configureHeartInformation((isGood, count.description))
        }
    }
}

// MARK: Comment Cell HeaderView Delegate Implementation
extension CommentCell: CommentCellHeaderViewDelegate {
    func didTapUserProfile() {
        transitionDelegate?.didTapUserProfile()
    }
    
    func didTapHeartButton() {
        commentCellDataSource?.checkHeart()
    }
}

// MARK: Configure UI
extension CommentCell {
    private func configureSubview() {
        [headerView, commentLabel].forEach {
            contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        headerView.delegate = self
    }
    
    private func configureLayout() {
        let safeArea = contentView.safeAreaLayoutGuide
        let idLabelLeadingAnchor = headerView.idLabelLeadingAnchor
        let heartButtonLeadingAnchor = headerView.heartButtonLeadingAnchor
        
        NSLayoutConstraint.activate([
            // MARK: headerView Constraint
            headerView.topAnchor.constraint(
                equalTo: safeArea.topAnchor
            ),
            headerView.leadingAnchor.constraint(
                equalTo: safeArea.leadingAnchor,
                constant: 15
            ),
            headerView.trailingAnchor.constraint(
                equalTo: safeArea.trailingAnchor,
                constant: -15
            ),
            headerView.heightAnchor.constraint(
                equalToConstant: 40
            ),
            
            // MARK: commentLabel Constraint
            commentLabel.topAnchor.constraint(
                equalTo: headerView.bottomAnchor
            ),
            commentLabel.leadingAnchor.constraint(
                equalTo: idLabelLeadingAnchor
            ),
            commentLabel.trailingAnchor.constraint(
                equalTo: heartButtonLeadingAnchor
            ),
            commentLabel.bottomAnchor.constraint(
                equalTo: safeArea.bottomAnchor
            )
            
//            // MARK: leaveCommentButton Constraint
//            leaveCommentButton.topAnchor.constraint(
//                equalTo: commentLabel.bottomAnchor
//            ),
//            leaveCommentButton.leadingAnchor.constraint(
//                equalTo: commentLabel.leadingAnchor,
//                constant: 30
//            ),
//            leaveCommentButton.bottomAnchor.constraint(
//                equalTo: safeArea.bottomAnchor
//            )
        ])
    }
}
