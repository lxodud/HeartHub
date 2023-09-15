//
//  HeartPickDataSource.swift
//  HeartHub
//
//  Created by 이태영 on 2023/08/03.
//

import UIKit

final class HeartPickDataSource: NSObject {
    private let heartPickPosts: [Any] = []
}

// MARK: CoupleSpace Pick DataSourceable Implementation
extension HeartPickDataSource: CoupleSpacePickDataSourceable {
    func fetchTitle() -> String {
        return "My Heart’s Pick"
    }
}

// MARK: UICollectionView DataSource Implementation
extension HeartPickDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return heartPickPosts.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        
        return UICollectionViewCell()
    }
}
