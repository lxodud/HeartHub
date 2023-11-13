//
//  AlbumRepositoryType.swift
//  HeartHub
//
//  Created by 이태영 on 2023/11/13.
//

import Foundation
import RxSwift

protocol AlbumRepositoryType {
    func postAlbum(with album: Album) -> Observable<Bool>
}
