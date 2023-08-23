//
//  LookViewController.swift
//  HeartHub
//
//  Created by 이태영 on 2023/07/20.
//

import UIKit

final class LookViewController: UIViewController {
    private let lookCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout
        )
        return collectionView
    }()
    
    private let articleDataSource: CommunityArticleDataSource
    private var articles: [Article] = [] {
        didSet {
            lookCollectionView.reloadData()
        }
    }
    
    // 유저의 차단상태 확인
    private var blockStatus: Bool = false
    
    init(articleDataSource: CommunityArticleDataSource) {
        self.articleDataSource = articleDataSource
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLookCollectionView()
        configureSubview()
        configureLayout()
        bindToArticleDataSource()
        articleDataSource.fetchArticle()
    }
    
    private func bindToArticleDataSource() {
        articleDataSource.articlesPublisher = { [weak self] articles in
            self?.articles = articles
        }
    }
}

// MARK: UICollectionView Delegate FlowLayout Implementation
extension LookViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let width = view.frame.width
        let estimateHeight = view.frame.height
        let size = CGRect(x: 0, y: 0, width: width, height: estimateHeight)
        let dummyCell = LookCell(frame: size)
        
        dummyCell.layoutIfNeeded()
        
        var height = dummyCell.fetchAdjustedHeight()
        
        if height > 542 {
            height = 542
        }
        
        return CGSize(width: width, height: height)
    }
}

// MARK: UICollectionView DataSource Implementation
extension LookViewController: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return articles.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: LookCell.reuseIdentifier,
            for: indexPath) as? LookCell
        else {
            return UICollectionViewCell()
        }
        
        let tokenRepository = TokenRepository()
        let networkManager = DefaultNetworkManager()
        
        let dataSource = CommunityCellDataSource(
            article: articles[indexPath.row],
            articleContentNetwork: ArticleContentNetwork(
                tokenRepository: tokenRepository,
                networkManager: networkManager
            ),
            userNetwork: UserNetwork(
                tokenRepository: tokenRepository,
                networkManager: networkManager
            )
        )
        
        cell.communityCellDataSource = dataSource
        cell.transitionDelegate = self
        
        return cell
    }
}

// MARK: Configure CollectionView
extension LookViewController {
    private func configureLookCollectionView()  {
        lookCollectionView.dataSource = self
        lookCollectionView.delegate = self
        lookCollectionView.register(
            LookCell.self,
            forCellWithReuseIdentifier: LookCell.reuseIdentifier
        )
    }
}

// MARK: Community Cell Delegate Implementation
extension LookViewController: CommunityCellTransitionDelegate {
    func didTapUserProfile() {
        
    }
    
    func didTapPostOption() {
        configureReportAlert()
    }
    
    func didTapCommentButton(_ articleID: Int?) {
        guard let articleID = articleID else {
            return
        }
        
        let commentDataSource = CommentDataSource(articleID: articleID)
        let commentViewController = CommentViewController(
            commentDataSource: commentDataSource
        )
        commentViewController.modalPresentationStyle = .custom
        commentViewController.transitioningDelegate = PanModalTransitioningDelegate.shared
        
        present(commentViewController, animated: true)
    }
}

// MARK: Configure ActionSheet
extension LookViewController {
    
    @objc func configureReportAlert() {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let report = UIAlertAction(title: "게시물 신고하기", style: .default) { (action) in
            self.presentReportUserViewController()
        }
        let block = UIAlertAction(title: "이 게시물의 작성자 차단하기", style: .default) { (action) in
            self.presentBlockUserViewController()
        }
        let cancelBlock = UIAlertAction(title: "차단 해제", style: .default) { (action) in
            self.presentCancelBlockUserViewController()
        }

        let cancel = UIAlertAction(title: "취소", style: .cancel)
                
        alert.addAction(report)
        if blockStatus == true {
            alert.addAction(cancelBlock)
        } else {
            alert.addAction(block)
        }
        alert.addAction(cancel)
                
        present(alert, animated: true, completion: nil)
    }
    
    private func presentReportUserViewController() {
        let reportUserViewController = ProfileReportReasonViewController()
        modalPresentationStyle = .overFullScreen
        present(reportUserViewController, animated: true)
    }
    
    private func presentBlockUserViewController() {
        let blockUserViewController = ProfileBlockUserViewController()
        modalPresentationStyle = .overFullScreen
        present(blockUserViewController, animated: true)
    }
    
    private func presentCancelBlockUserViewController() {
        let profileBlockCancelViewController = ProfileBlockCancelViewController()
        modalPresentationStyle = .overFullScreen
        present(profileBlockCancelViewController, animated: true)
    }
}

// MARK: Configure UI
extension LookViewController {
    private func configureSubview() {
        view.addSubview(lookCollectionView)
        lookCollectionView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configureLayout() {
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            // MARK: lookCollectionView Constraint
            lookCollectionView.topAnchor.constraint(
                equalTo: safeArea.topAnchor
            ),
            lookCollectionView.leadingAnchor.constraint(
                equalTo: safeArea.leadingAnchor
            ),
            lookCollectionView.trailingAnchor.constraint(
                equalTo: safeArea.trailingAnchor
            ),
            lookCollectionView.bottomAnchor.constraint(
                equalTo: safeArea.bottomAnchor
            ),
        ])
    }
}
