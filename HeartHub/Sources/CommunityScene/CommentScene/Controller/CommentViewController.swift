//
//  CommentViewController.swift
//  HeartHub
//
//  Created by 이태영 on 2023/07/25.
//

import UIKit

final class CommentViewController: UIViewController {
    private let commentDataSource: CommentDataSource
    private var comments: [Comment] = [] {
        didSet {
            commentTableView.reloadData()
        }
    }
    
    private let commentTableView = UITableView()
    private let activityIndicator = UIActivityIndicatorView()
    private let commentTextView: UITextView = {
        let textView = UITextView()
        textView.textContainerInset = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 40)
        textView.font = .systemFont(ofSize: 16)
        textView.isScrollEnabled = false
        textView.backgroundColor = .green
        textView.layer.cornerRadius = 10
        textView.layer.borderWidth = 1
        return textView
    }()
    
    private let profileImageView: UIImageView = {
        let imageView = HeartHubProfileImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let commentStickyView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray3
        return view
    }()
    
    private let commentPostButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "paperplane.fill"), for: .normal)
        button.setImage(UIImage(systemName: "paperplane"), for: .disabled)
        return button
    }()
    
    private let headerView: UIView = {
        let view = UIView()
        return view
    }()
    
    init(commentDataSource: CommentDataSource) {
        self.commentDataSource = commentDataSource
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        configureCommentTableView()
        configureCommentTextView()
        configureSubview()
        configureLayout()
        configureAction()
        bind(to: commentDataSource)
        commentDataSource.fetchComment()
        commentDataSource.fetchUserProfile()
    }
    
    private func bind(to dataSource: CommentDataSource) {
        dataSource.commentsPublisher = { [weak self] comments in
            self?.comments = comments
        }
        
        dataSource.userProfileImagePublisher = { [weak self] imageData in
            self?.profileImageView.image = UIImage(data: imageData)
        }
    }
}

// MARK: - Configure Action
extension CommentViewController {
    private func configureAction() {
        commentPostButton.addTarget(
            self,
            action: #selector(tapPostButton),
            for: .touchUpInside
        )
    }
    
    @objc
    private func tapPostButton() {
        guard let content = commentTextView.text else {
            return
        }
        
        activityIndicator.startAnimating()
        commentPostButton.isEnabled = false
        
        commentDataSource.postComment(content) {
            self.activityIndicator.stopAnimating()
            self.commentPostButton.isEnabled = true
            self.commentTextView.text = ""
        }
    }
}

// MARK: PanModal Presentable Imaplementation
extension CommentViewController: PanModalPresentable {
    var scrollView: UIScrollView? {
        return commentTableView
    }
    
    var stickyView: UIView? {
        return commentStickyView
    }
    
    var isStickyViewFirstResponder: Bool {
        return commentTextView.isFirstResponder
    }
    
    func canRespond(to panModalGestureRecognizer: UIPanGestureRecognizer) -> Bool {
        let location = panModalGestureRecognizer.location(in: view)
        return headerView.frame.contains(location)
    }
    
    func resignStickyViewFirstResponder() {
        commentTextView.resignFirstResponder()
    }
}

// MARK: UITableView DataSource Implementation
extension CommentViewController: UITableViewDataSource {
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return comments.count
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: CommentCell.reuseIdentifier,
            for: indexPath
        ) as? CommentCell else {
            return UITableViewCell()
        }
        
        let tokenRepository = TokenRepository()
        let networkManager = DefaultNetworkManager()
        
        let dataSource = CommentCellDataSource(
            comment: comments[indexPath.row],
            commentContentNetwork: CommentContentNetwork(
                tokenRepository: tokenRepository,
                networkManager: networkManager
            ),
            userNetwork: UserNetwork(
                tokenRepository: tokenRepository,
                networkManager: networkManager
            )
        )
        
        cell.commentCellDataSource = dataSource
        cell.commentLabel.text = comments[indexPath.row].content
        return cell
    }
}

// MARK: UITextView Delegate Implementation
extension CommentViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        let size = CGSize(width: textView.frame.width, height: .infinity)
        let estimatedSize = textView.sizeThatFits(size)
        
        if estimatedSize.height > 60 {
            textView.isScrollEnabled = true
        } else if estimatedSize.height <= 60 {
            textView.isScrollEnabled = false
        }
    }
}

// MARK: Configure TableView
extension CommentViewController {
    private func configureCommentTableView() {
        commentTableView.dataSource = self
        commentTableView.register(
            CommentCell.self,
            forCellReuseIdentifier: CommentCell.reuseIdentifier
        )
    }
}

// MARK: Configure TextView
extension CommentViewController {
    private func configureCommentTextView() {
        commentTextView.delegate = self
    }
}

// MARK: Configure UI
extension CommentViewController {
    private func configureSubview() {
        [profileImageView, commentTextView, commentPostButton].forEach {
            commentStickyView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        [commentTableView, headerView, activityIndicator].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        view.backgroundColor = .systemBackground
        commentTableView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configureLayout() {
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            // MARK: activityIndicator Constraint
            activityIndicator.centerXAnchor.constraint(
                equalTo: safeArea.centerXAnchor
            ),
            activityIndicator.centerYAnchor.constraint(
                equalTo: safeArea.centerYAnchor
            ),
            
            // MARK: headerView Constraint
            headerView.topAnchor.constraint(
                equalTo: safeArea.topAnchor
            ),
            headerView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor
            ),
            headerView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor
            ),
            headerView.heightAnchor.constraint(
                equalToConstant: 80
            ),
            
            // MARK: commentTableView Constraint
            commentTableView.topAnchor.constraint(
                equalTo: headerView.bottomAnchor
            ),
            commentTableView.leadingAnchor.constraint(
                equalTo: safeArea.leadingAnchor
            ),
            commentTableView.trailingAnchor.constraint(
                equalTo: safeArea.trailingAnchor
            ),
            commentTableView.bottomAnchor.constraint(
                equalTo: view.bottomAnchor,
                constant: -110
            ),
            
            // MARK: profileImageView Constraint
            profileImageView.leadingAnchor.constraint(
                equalTo: commentStickyView.leadingAnchor,
                constant: 15
            ),
            profileImageView.centerYAnchor.constraint(
                equalTo: commentStickyView.centerYAnchor
            ),
            profileImageView.widthAnchor.constraint(
                equalTo: commentStickyView.widthAnchor,
                multiplier: 0.1
            ),
            profileImageView.heightAnchor.constraint(
                equalTo: profileImageView.widthAnchor
            ),
            
            // MARK: commentTextView Constraint
            commentTextView.leadingAnchor.constraint(
                equalTo: profileImageView.trailingAnchor,
                constant: 8
            ),
            commentTextView.trailingAnchor.constraint(
                equalTo: commentStickyView.trailingAnchor,
                constant: -15
            ),
            commentTextView.bottomAnchor.constraint(
                equalTo: profileImageView.bottomAnchor
            ),
            commentTextView.heightAnchor.constraint(
                lessThanOrEqualToConstant: 60
            ),
            
            // MARK: commentPostButton Constraint
            commentPostButton.trailingAnchor.constraint(
                equalTo: commentTextView.trailingAnchor,
                constant: -4
            ),
            commentPostButton.bottomAnchor.constraint(
                equalTo: commentTextView.bottomAnchor,
                constant: -4
            ),
        ])
    }
}

