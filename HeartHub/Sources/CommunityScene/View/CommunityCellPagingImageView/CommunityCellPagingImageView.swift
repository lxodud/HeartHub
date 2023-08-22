//
//  CommunityCellPagingImageView.swift
//  HeartHub
//
//  Created by 이태영 on 2023/07/17.
//

import UIKit

final class CommunityCellPagingImageView: UIView {
    private var images: [UIImage?] = [] {
        didSet {
            configurePageControl()
            pagingImageCollectionView.reloadData()
        }
    }
    
    private let pagingImageCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout
        )
        return collectionView
    }()
    
    private let imagePageControl: UIPageControl = {
        let pageControl = UIPageControl()
        return pageControl
    }()
    
    convenience init() {
        self.init(frame: .zero)
        configurePagingImageCollectionView()
        configureSubview()
        configureLayout()
    }
}

// MARK: Public Interface
extension CommunityCellPagingImageView {
    func configureContents(_ images: [UIImage?]) {
        self.images = images
    }
}

// MARK: UIScrollView Delegate Implementation
extension CommunityCellPagingImageView {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let width = scrollView.frame.width

        if width != 0 {
            let currentPosition = scrollView.contentOffset.x / width
            imagePageControl.currentPage = Int(currentPosition)
        }
    }
}

// MARK: UICollectionView Delegate FlowLayout Implementation
extension CommunityCellPagingImageView: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let width: CGFloat = collectionView.bounds.width
        let height: CGFloat = collectionView.bounds.height
        
        return CGSize(width: width, height: height)
    }
}

// MARK: UICollectionView DataSource Implementation
extension CommunityCellPagingImageView: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return images.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: PagingImageCollectionViewCell.reuseIdentifier,
            for: indexPath
        ) as? PagingImageCollectionViewCell
        else {
            return UICollectionViewCell()
        }
        
        cell.imageView.image = images[indexPath.row]
        return cell
    }
}

// MARK: Configure UI
extension CommunityCellPagingImageView {
    private func configurePageControl() {
        imagePageControl.numberOfPages = images.count
        imagePageControl.hidesForSinglePage = true
    }
    
    private func configurePagingImageCollectionView() {
        pagingImageCollectionView.dataSource = self
        pagingImageCollectionView.delegate = self
        pagingImageCollectionView.register(
            PagingImageCollectionViewCell.self,
            forCellWithReuseIdentifier: PagingImageCollectionViewCell.reuseIdentifier
        )
        
        pagingImageCollectionView.isPagingEnabled = true
        pagingImageCollectionView.showsHorizontalScrollIndicator = false
    }
    
    private func configureSubview() {
        [pagingImageCollectionView, imagePageControl].forEach {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    private func configureLayout() {
        let safeArea = safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            // MARK: pagingImageCollectionView Constraint
            pagingImageCollectionView.topAnchor.constraint(
                equalTo: safeArea.topAnchor
            ),
            pagingImageCollectionView.leadingAnchor.constraint(
                equalTo: safeArea.leadingAnchor
            ),
            pagingImageCollectionView.trailingAnchor.constraint(
                equalTo: safeArea.trailingAnchor
            ),
            pagingImageCollectionView.heightAnchor.constraint(
                equalTo: safeArea.heightAnchor
            ),
            
            // MARK: imagePageControl Constraint
            imagePageControl.bottomAnchor.constraint(
                equalTo: pagingImageCollectionView.bottomAnchor
            ),
            imagePageControl.centerXAnchor.constraint(
                equalTo: safeArea.centerXAnchor
            ),
            imagePageControl.heightAnchor.constraint(
                equalTo: safeArea.heightAnchor,
                multiplier: 0.05
            )

        ])
    }
}
