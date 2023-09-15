//
//  CoupleSpacePickDataSourceable.swift
//  HeartHub
//
//  Created by 이태영 on 2023/08/04.
//

import UIKit

protocol CoupleSpacePickDataSourceable: NSObject, UICollectionViewDataSource {
    func fetchTitle() -> String
}
