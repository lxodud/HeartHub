//
//  CommunityAriticleDataSource.swift
//  HeartHub
//
//  Created by 이태영 on 2023/08/21.
//

import Foundation

final class CommunityArticleDataSource {
    private var articles: [Article] = [] {
        didSet {
            articlesPublisher?(articles)
        }
    }
    private let articleNetwork = ArticleNetwork(
        tokenRepository: TokenRepository(),
        networkManager: DefaultNetworkManager()
    )
    private let articleTheme: ArticleTheme
    
    // MARK: - Output
    var articlesPublisher: (([Article]) -> Void)?
    
    init(articleTheme: ArticleTheme) {
        self.articleTheme = articleTheme
    }
}

// MARK: - Input
extension CommunityArticleDataSource {
    func fetchArticle() {
        articleNetwork.fetchArticle(with: articleTheme) { articles in
            self.articles = articles
        }
    }
}

// MARK: - Add Article Delegate Implementation
extension CommunityArticleDataSource: UpdateArticleDelegate {
    func updateNewArticle(_ theme: ArticleTheme, _ article: Article) {
        guard self.articleTheme == theme else {
            return
        }
        
        articles.insert(article, at: 0)
    }
}
