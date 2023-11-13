//
//  AlbumRepository.swift
//  HeartHub
//
//  Created by 이태영 on 2023/11/13.
//

import Foundation
import RxSwift

final class AlbumRepository {
    private let networkManager: NetworkManagerType
    
    init(networkManager: NetworkManagerType = NetworkManager()) {
        self.networkManager = networkManager
    }
}

// MARK: Public Interface
extension AlbumRepository: AlbumRepositoryType {
    func postAlbum(with album: Album) -> Observable<Bool> {
        guard let builder = try? CoupleSpaceRequestBuilderFactory.makePostAlbumRequest(
            image: album.image,
            title: album.title,
            body: album.body
        ) else {
            return Observable.of(false)
        }
        
        return networkManager.request(builder)
            .map { $0.isSuccess }
    }
}
