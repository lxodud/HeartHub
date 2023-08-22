//
//  CommunityCellDataSource.swift
//  HeartHub
//
//  Created by 이태영 on 2023/08/21.
//

import Foundation

final class CommunityCellDataSource {
    let article: Article
    private var goodInformation: (status: Bool, count: Int) = (false, 0) {
        didSet {
            DispatchQueue.main.async {
                self.goodInformationPublisher?(
                    self.goodInformation.status,
                    self.goodInformation.count
                )
            }
        }
    }
    private var heartStatus: Bool = false {
        didSet {
            DispatchQueue.main.async {
                self.heartStatusPublisher?(self.heartStatus)
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
    private var commentCount: Int = 0 {
        didSet {
            DispatchQueue.main.async {
                self.commentCountPublisher?(self.commentCount)
            }
        }
    }
    private var images: [Data] = [] {
        didSet {
            DispatchQueue.main.async {
                self.imagesPublisher?(self.images)
            }
        }
    }
    private let articleContentNetwork: ArticleContentNetwork
    private let userNetwork: UserNetwork
    
    // MARK: - Output
    var goodInformationPublisher: ((Bool, Int) -> Void)?
    var heartStatusPublisher: ((Bool) -> Void)?
    var imagesPublisher: (([Data]) -> Void)?
    var contentPublisher: ((String) -> Void)?
    var authorProfileInformationPublisher: ((String, Data?) -> Void)?
    var commentCountPublisher: ((Int) -> Void)?
    
    init(
        article: Article,
        articleContentNetwork: ArticleContentNetwork,
        userNetwork: UserNetwork
    ) {
        self.article = article
        self.articleContentNetwork = articleContentNetwork
        self.userNetwork = userNetwork
    }
}

// MARK: - Input
extension CommunityCellDataSource {
    func fetchCellContents() -> [Cancellable?] {
        var tasks: [Cancellable?] = []
        
        tasks.append(fetchAuthorInformation())
        tasks += fetchGoodInformation()
        tasks += fetchImages()
        
        content = article.content
        commentCount = article.commentList.count
        
        return tasks
    }
    
    func checkGoodArticle() -> Cancellable? {
        if goodInformation.status {
            goodInformation.status = false
            goodInformation.count -= 1
        } else {
            goodInformation.status = true
            goodInformation.count += 1
        }
        
        return postGoodStatus()
    }
    
    func scrapOrCancelArticle() -> Cancellable? {
        heartStatus = !heartStatus
        
        return postScrabOrCancel()
    }
}

// MARK: - Network
extension CommunityCellDataSource {
    private func fetchHeartStatus() -> Cancellable? {
        articleContentNetwork.fetchHeartStatus(from: article.articleID) { status in
            self.heartStatus = status
        }
    }
    
    private func postScrabOrCancel() -> Cancellable? {
        articleContentNetwork.postScrapOrCancelArticle(
            username: article.username,
            articleID: article.articleID
        )
    }
    
    private func postGoodStatus() -> Cancellable? {
        return articleContentNetwork.postGoodArticle(
            username: article.username,
            articleID: article.articleID
        )
    }
    
    private func fetchImages() -> [Cancellable?] {
        let serialQueue = DispatchQueue(label: "fetch image")
        
        var tasks: [Cancellable?] = []
        
        article.communityImageUrl.forEach {
            guard let url = URL(string: $0) else {
                return
            }
            
            let task = ImageProvider.shared.fetch(from: url, queue: serialQueue) { result in
                switch result {
                case .success(let data):
                    self.images.append(data)
                case .failure(let error):
                    print(error)
                }
            }
            
            tasks.append(task)
        }
        
        return tasks
    }
    
    private func fetchGoodInformation() -> [Cancellable?] {
        let dispatchGroup = DispatchGroup()
        var goodCount: Int = 0
        var goodStatus: Bool = false
        
        dispatchGroup.enter()
        let countTask = articleContentNetwork.fetchGoodCount(from: article.articleID) { count in
            goodCount = count
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        let statuTask = articleContentNetwork.fetchGoodStatus(from: article.articleID) { status in
            goodStatus = status
            dispatchGroup.leave()
        }
        
        dispatchGroup.notify(queue: .main) {
            self.goodInformation = (goodStatus, goodCount)
        }
        
        return [countTask, statuTask]
    }
    
    private func fetchAuthorInformation() -> Cancellable? {
        return userNetwork.fetchAuthorInformation(from: article.userID) { imageLocation in
            guard let imageLocation = imageLocation,
                  let imageUrl = URL(string: imageLocation)
            else {
                self.authorProfileInformation = (self.article.username, nil)
                return
            }
            
            ImageProvider.shared.fetch(from: imageUrl) { result in
                switch result {
                case .success(let data):
                    self.authorProfileInformation = (self.article.username, data)
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}
