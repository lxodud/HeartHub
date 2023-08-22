//
//  CommentCellDataSource.swift
//  HeartHub
//
//  Created by 이태영 on 2023/08/22.
//

import Foundation

final class CommentCellDataSource {
    let comment: Comment
    
    private var heartInformation: (status: Bool, count: Int) = (false, 0) {
        didSet {
            DispatchQueue.main.async {
                self.heartInformationPublisher?(
                    self.heartInformation.status,
                    self.heartInformation.count
                )
            }
        }
    }
    private var content: String = "" {
        didSet {
            DispatchQueue.main.async {
                self.contentPublisher?(self.content)
            }
        }
    }
    private var authorProfileInformation: (username: String, image: Data?) = ("", nil) {
        didSet {
            DispatchQueue.main.async {
                self.authorProfileInformationPublisher?(
                    self.authorProfileInformation.username,
                    self.authorProfileInformation.image
                )
            }
        }
    }
    private let userNetwork: UserNetwork
    private let commentContentNetwork: CommentContentNetwork
    
    // MARK: - Output
    var heartInformationPublisher: ((Bool, Int) -> Void)?
    var contentPublisher: ((String) -> Void)?
    var authorProfileInformationPublisher: ((String, Data?) -> Void)?
    
    init(
        comment: Comment,
        commentContentNetwork: CommentContentNetwork,
        userNetwork: UserNetwork
    ) {
        self.comment = comment
        self.commentContentNetwork = commentContentNetwork
        self.userNetwork = userNetwork
    }
}

// MARK: - Input
extension CommentCellDataSource {
    func fetchCellContents() -> [Cancellable?] {
        var tasks: [Cancellable?] = []
        
        tasks.append(fetchAuthorInformation())
        fetchHeartStatus()
        content = comment.content ?? ""
        
        return tasks
    }
    
    func checkHeart() {
        if heartInformation.status {
            heartInformation.status = false
            heartInformation.count -= 1
            deleteCommentHeart()
        } else {
            heartInformation.status = true
            heartInformation.count += 1
            postCommentHeart()
        }
    }
}

// MARK: - Network
extension CommentCellDataSource {
    private func deleteCommentHeart() {
        guard let username = UserInformationRepository().fetchUsername() else {
            return
        }
        
        commentContentNetwork.deleteHeartComment(
            id: comment.commentID,
            username: username
        )
    }
    
    private func postCommentHeart() {
        commentContentNetwork.postHeartComment(with: comment.commentID)
    }

    private func fetchHeartStatus() {
        commentContentNetwork.fetchHeartStatus(with: comment.commentID) { isGood in
            self.heartInformation = (isGood, self.comment.heartCount)
        }
    }
    
    private func fetchAuthorInformation() -> Cancellable? {
        let task = userNetwork.fetchAuthorInformation(from: comment.userID) { imageLocation in
            guard let imageLocation = imageLocation,
                  let imageUrl = URL(string: imageLocation)
            else {
                self.authorProfileInformation = (self.comment.username, nil)
                return
            }
            
            ImageProvider.shared.fetch(from: imageUrl) { result in
                switch result {
                case .success(let data):
                    self.authorProfileInformation = (self.comment.username, data)
                case .failure(let error):
                    print(error)
                }
            }
        }
        
        return task
    }
}
