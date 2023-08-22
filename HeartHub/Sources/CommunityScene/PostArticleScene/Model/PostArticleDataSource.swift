//
//  PostArticleDataSource.swift
//  HeartHub
//
//  Created by 이태영 on 2023/08/22.
//

import Foundation

final class PostArticleDataSource {
    private let updateArticleDelegateList: [UpdateArticleDelegate]
    private let userInfoRespository = UserInformationRepository()
    private let articleNetwork = ArticleNetwork(
        tokenRepository: TokenRepository(),
        networkManager: DefaultNetworkManager()
    )
    
    private var userInformation: (username: String?, image: Data?) {
        didSet {
            guard let username = userInformation.username,
                  let image = userInformation.image
            else {
                return
            }
            
            userInformationPublisher?(username, image)
        }
    }
    
    var userInformationPublisher: ((String, Data) -> Void)?
    
    init(updateArticleDelegateList: [UpdateArticleDelegate]) {
        self.updateArticleDelegateList = updateArticleDelegateList
    }
}

// MARK: - Input
extension PostArticleDataSource {
    func fetchUserInformation() {
        guard let username = userInfoRespository.fetchUsername(),
              let profileImage = userInfoRespository.fetchProfileImage()
        else {
            return
        }
        
        self.userInformation = (username, profileImage)
    }
    
    func postArticle(
        _ imageData: [Data],
        _ content: String,
        _ theme: ArticleTheme,
        _ completion: @escaping () -> Void
    ) {
        guard let username = userInformation.username else {
            return
        }
        
        articleNetwork.postArticle(
            username: username,
            imageData: imageData,
            content: content,
            theme: theme
        ) { article in
            DispatchQueue.main.async {
                self.updateArticleDelegateList.forEach {
                    $0.updateNewArticle(theme, article)
                }
                completion()
            }
        }
    }
}
