//
//  AlbumUseCaseType.swift
//  HeartHub
//
//  Created by 이태영 on 2023/11/13.
//

import Foundation
import RxSwift

protocol AlbumUseCaseType {
    func fetchAlbum() -> Observable<[Album]>
    func postAlbum(_ album: Album) -> Observable<Bool>
}
