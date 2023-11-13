//
//  AlbumCoordinatable.swift
//  HeartHub
//
//  Created by 이태영 on 2023/11/09.
//

import Foundation

protocol AlbumCoordinatable: Coordinatable {
    func toPost()
    func toImagePicker()
    func finish()
}
