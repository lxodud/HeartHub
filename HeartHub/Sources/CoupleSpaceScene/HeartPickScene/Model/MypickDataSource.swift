//
//  MypickDataSource.swift
//  HeartHub
//
//  Created by 이태영 on 2023/08/04.
//

import UIKit

final class MyPickDataSource: NSObject {
    private let myPickPosts: [Any] = []
}

// MARK: CoupleSpace Pick DataSourceable Implementation
extension MyPickDataSource: CoupleSpacePickDataSourceable {
    func fetchTitle() -> String {
        return "My Pick"
    }
}

// MARK: UICollectionView DataSource Implementation
extension MyPickDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return myPickPosts.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
}
