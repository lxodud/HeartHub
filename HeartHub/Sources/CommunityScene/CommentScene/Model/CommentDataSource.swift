//
//  CommentDataSource.swift
//  HeartHub
//
//  Created by 이태영 on 2023/08/22.
//

import Foundation

final class CommentDataSource {
    private var comments: [Comment] = [] {
        didSet {
            DispatchQueue.main.async {
                self.commentsPublisher?(self.comments)
            }
        }
    }
    
    private var userProfileImage: Data? {
        didSet {
            guard let userProfileImage = userProfileImage else {
                return
            }
            
            userProfileImagePublisher?(userProfileImage)
        }
    }
    
    private let commentNetwork = CommentNetwork(
        tokenRepository: TokenRepository(),
        networkManager: DefaultNetworkManager()
    )
    private let articleID: Int
    
    // MARK: - Output
    var commentsPublisher: (([Comment]) -> Void)?
    var userProfileImagePublisher: ((Data) -> Void)?
    
    init(articleID: Int) {
        self.articleID = articleID
    }
}

// MARK: - Input
extension CommentDataSource {
    func fetchUserProfile() {
        let userInformationRepository = UserInformationRepository()
        userProfileImage = userInformationRepository.fetchProfileImage()
    }
    
    func fetchComment() {
        commentNetwork.fetchComment(with: articleID) { comments in
            self.comments = comments
        }
    }
    
    func postComment(_ content: String, completion: @escaping () -> Void) {
        guard let username = UserInformationRepository().fetchUsername() else {
            return
        }
        
        commentNetwork.postComment(
            username: username,
            articleID: articleID,
            content: content
        ) {
            self.fetchComment()
            DispatchQueue.main.async {
                completion()
            }
        }
    }
}
