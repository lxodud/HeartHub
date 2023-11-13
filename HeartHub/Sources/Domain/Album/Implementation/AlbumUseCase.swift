//
//  AlbumUseCase.swift
//  HeartHub
//
//  Created by 이태영 on 2023/11/13.
//

import Foundation
import RxSwift

final class AlbumUseCase {
    private let albumRepository: AlbumRepositoryType
    private let albumSubject = BehaviorSubject(value: mockAlbum)
    
    private var album: [Album] = mockAlbum {
        didSet {
            albumSubject.onNext(album)
        }
    }
    
    init(albumRepository: AlbumRepositoryType = AlbumRepository()) {
        self.albumRepository = albumRepository
    }
}

// MARK: Public Interface
extension AlbumUseCase: AlbumUseCaseType {
    func fetchAlbum() -> Observable<[Album]> {
        return albumSubject.asObserver()
    }
    
    func postAlbum(_ album: Album) -> Observable<Bool> {
        self.album.insert(album, at: 0)
        return albumRepository.postAlbum(with: album)
    }
}

let mockAlbum = [
    Album(
        image: album1,
        title: "안",
        body: "녕",
        createdDate: Date(),
        dday: Date()
    ),
    Album(
        image: album2,
        title: "안",
        body: "녕",
        createdDate: Date(),
        dday: Date()
    ),
    Album(
        image: album3,
        title: "안",
        body: "녕",
        createdDate: Date(),
        dday: Date()
    ),
    Album(
        image: album4,
        title: "안",
        body: "녕",
        createdDate: Date(),
        dday: Date()
    ),
    Album(
        image: album5,
        title: "안",
        body: "녕",
        createdDate: Date(),
        dday: Date()
    ),
]
