//
//  AlbumPostViewModel.swift
//  HeartHub
//
//  Created by 이태영 on 2023/11/10.
//

import Foundation
import RxCocoa
import RxSwift

final class AlbumPostViewModel: ViewModelType {
    struct Input {
        let imagePickerTap: Driver<Void>
        let title: Driver<String>
        let body: Driver<String>
        let textViewEditEnd: Driver<Void>
        let textViewEditStart: Driver<Void>
        let postTap: Driver<Void>
        let cancelTap: Driver<Void>
    }
    
    struct Output {
        let toImagePicker: Driver<Void>
        let bodyPlaceholder: Driver<String>
        let bodyColor: Driver<AlbumPostColor>
        let postEnalble: Driver<Bool>
        let postImage: Driver<Data>
        let cancel: Driver<Void>
        let posting: Driver<Bool>
        let postSuccess: Driver<Void>
    }
    
    private let coordinator: AlbumCoordinatable
    private let albumUseCase: AlbumUseCaseType
    private let pickedImageRelay = PublishRelay<Data>()

    private let bodyPlaceholder = "내용을 입력해주세요."
    
    init(
        coordinator: AlbumCoordinatable,
        albumUseCase: AlbumUseCaseType
    ) {
        self.coordinator = coordinator
        self.albumUseCase = albumUseCase
    }
}

// MARK: Public Interface
extension AlbumPostViewModel {
    func transform(_ input: Input) -> Output {
        let toImagePicker = input.imagePickerTap
            .do { _ in self.coordinator.toImagePicker() }
        
        let isBodyEmpty = input.textViewEditEnd.withLatestFrom(input.body)
            .filter { $0.isEmpty }
        
        let isBodyPlaceholder = input.textViewEditStart.withLatestFrom(input.body)
            .filter { $0 == self.bodyPlaceholder }
        
        let bodyEmptyOrPlaceholder = Driver.from([
            isBodyEmpty.map { _ in true },
            isBodyPlaceholder.map { _ in false }
        ])
            .merge()
            .distinctUntilChanged()
            
        let bodyPlaceholder = bodyEmptyOrPlaceholder
            .map { isEmpty in
                isEmpty ? self.bodyPlaceholder : ""
            }
        
        let bodyColor = bodyEmptyOrPlaceholder
            .map { isPlaceholder in
                isPlaceholder ? AlbumPostColor.placeholder : AlbumPostColor.text
            }
        
        let imagePicked = pickedImageRelay.map { _ in true }
            .asDriver(onErrorJustReturn: false)
        
        let postEnable = Driver.combineLatest(input.title, input.body, imagePicked) { title, body, imagePicked in
            return !title.isEmpty && !body.isEmpty && body != self.bodyPlaceholder && imagePicked
        }
        
        let cancel = input.cancelTap
            .do { _ in self.coordinator.finish() }
        
        let postImage = pickedImageRelay.asDriver(onErrorJustReturn: Data())
        
        let titleBodyImage = Driver.combineLatest(input.title, input.body, postImage) { title, body, image in
            return (title: title, body: body, image: image)
        }
        
        let postSuccess = input.postTap.withLatestFrom(titleBodyImage)
            .flatMap {
                return self.albumUseCase.postAlbum(
                    Album(
                        image: $0.image,
                        title: $0.title,
                        body: $0.body,
                        createdDate: Date(),
                        dday: Date()
                    )
                ).asDriver(onErrorJustReturn: false)
            }
            .do { _ in self.coordinator.finish() }
            .map { _ in }
        
        let posting = Driver.from([
            input.postTap.map { _ in true },
            postSuccess.map { _ in false }
        ])
            .merge()
            .distinctUntilChanged()

        return Output(
            toImagePicker: toImagePicker,
            bodyPlaceholder: bodyPlaceholder,
            bodyColor: bodyColor,
            postEnalble: postEnable,
            postImage: postImage,
            cancel: cancel,
            posting: posting,
            postSuccess: postSuccess
        )
    }
}

// MAKR: HeartHubImagePickerDelegate Implementation
extension AlbumPostViewModel: HeartHubImagePickerDelegate {
    func passSelectedImage(_ image: Data) {
        pickedImageRelay.accept(image)
    }
}
