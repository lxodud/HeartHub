//
//  AlbumViewModel.swift
//  HeartHub
//
//  Created by 이태영 on 2023/11/09.
//

import Foundation
import RxCocoa
import RxSwift

final class AlbumViewModel: ViewModelType {
    struct Input {
        let viewWillAppear: Driver<Void>
        let tapPost: Driver<Void>
    }
    
    struct Output {
        let album: Driver<[AlbumItemViewModel]>
        let toPost: Driver<Void>
    }
    
    private let coordinator: AlbumCoordinatable
    private let albumUseCase: AlbumUseCaseType
    
    init(
        coordinator: AlbumCoordinatable,
        albumUseCase: AlbumUseCaseType
    ) {
        self.coordinator = coordinator
        self.albumUseCase = albumUseCase
    }
}

// MARK: Public Interface
extension AlbumViewModel {
    func transform(_ input: Input) -> Output {
        let album = input.viewWillAppear
            .flatMap {
                return self.albumUseCase.fetchAlbum()
                    .asDriver(onErrorJustReturn: [])
            }
            .map { $0.map { AlbumItemViewModel(with: $0) } }
            
        
        let toPost = input.tapPost
            .do { _ in
                self.coordinator.toPost()
            }
        
        return Output(
            album: album,
            toPost: toPost
        )
    }
}

struct AlbumItemViewModel {
    let image: Data
    let title: String
    let body: String
    let createdDate: String
    let dday: String
    
    init(with album: Album) {
        self.image = album.image
        self.title = album.title
        self.body = album.body
        
        //TODO: 날짜 변환 구현
        self.createdDate = HeartHubDateFormatter.shared.stringForPresentation(from: album.createdDate)
        self.dday = HeartHubDateFormatter.shared.stringForDday(from: album.dday)
    }
}
