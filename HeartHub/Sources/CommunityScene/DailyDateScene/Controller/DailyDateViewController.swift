//
//  DailyViewController.swift
//  HeartHub
//
//  Created by 이태영 on 2023/07/06.
//

import UIKit

final class DailyDateViewController: UIViewController {
    private let dailyCollectionView: UICollectionView = {
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
            dailyCollectionView.reloadData()
        }
    }
    
    init(articleDataSource: CommunityArticleDataSource) {
        self.articleDataSource = articleDataSource
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureDailyCollectionView()
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
extension DailyDateViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let width = view.frame.width
        let estimateHeight = view.frame.height
        let size = CGRect(x: 0, y: 0, width: width, height: estimateHeight)
        var dummyCell: CommunityCellable
        
        if articles[indexPath.row].communityImageUrl.isEmpty {
            dummyCell = DailyDateNoImageCell(frame: size)
        } else {
            dummyCell = DailyDateImageCell(frame: size)
        }
        
        dummyCell.layoutIfNeeded()
        
        let height = dummyCell.fetchAdjustedHeight()
        
        return CGSize(width: width, height: height)
    }
}

// MARK: UICollectionView DataSource Implementation
extension DailyDateViewController: UICollectionViewDataSource {
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
        
        let cellType: CommunityCellable.Type
        
        if articles[indexPath.row].communityImageUrl.isEmpty {
            cellType = DailyDateNoImageCell.self
        } else {
            cellType = DailyDateImageCell.self
        }
        
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: cellType.reuseIdentifier,
            for: indexPath
        ) as? CommunityCellable else {
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

// MARK: Community Cell Delegate Implementation
extension DailyDateViewController: CommunityCellTransitionDelegate {
    func didTapUserProfile() {
        
    }
    
    func didTapPostOption() {
        
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

// MARK: Configure CollectionView
extension DailyDateViewController {
    private func configureDailyCollectionView()  {
        dailyCollectionView.dataSource = self
        dailyCollectionView.delegate = self
        
        dailyCollectionView.register(
            DailyDateImageCell.self,
            forCellWithReuseIdentifier: DailyDateImageCell.reuseIdentifier
        )
        dailyCollectionView.register(
            DailyDateNoImageCell.self,
            forCellWithReuseIdentifier: DailyDateNoImageCell.reuseIdentifier
        )
    }
}

// MARK: Configure UI
extension DailyDateViewController {
    private func configureSubview() {
        view.addSubview(dailyCollectionView)
        dailyCollectionView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configureLayout() {
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            dailyCollectionView.topAnchor.constraint(
                equalTo: safeArea.topAnchor
            ),
            dailyCollectionView.leadingAnchor.constraint(
                equalTo: safeArea.leadingAnchor
            ),
            dailyCollectionView.trailingAnchor.constraint(
                equalTo: safeArea.trailingAnchor
            ),
            dailyCollectionView.bottomAnchor.constraint(
                equalTo: safeArea.bottomAnchor
            ),
        ])
    }
}
