//
//  HeartHubImagePickerViewController.swift
//  HeartHub
//
//  Created by 이태영 on 2023/09/06.
//

import UIKit
import Photos

protocol HeartHubImagePickerDelegate: AnyObject {
    func passSelectedImage(_ image: UIImage)
}

final class HeartHubImagePickerViewController: UIViewController {
    weak var delegate: HeartHubImagePickerDelegate?
    
    private let imageCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 3
        layout.minimumInteritemSpacing = 3
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout
        )
        
        return collectionView
    }()
    private var selectedCellIndexPath: IndexPath?
    
    private var fetchResult = PHFetchResult<PHAsset>()
    private let thumbnailSize = {
        let scale = UIScreen.main.scale
        return CGSize(width: (UIScreen.main.bounds.width / 3) * scale, height: 100 * scale)
    }()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        checkAuthorization()
        configureSubview()
        configureLayout()
        configureImageCollectionView()
    }
}

// MARK: - Photos
extension HeartHubImagePickerViewController {
    private func checkAuthorization() {
        PHPhotoLibrary.requestAuthorization(for: .readWrite) { status in
            switch status {
            case .authorized, .limited:
                PHPhotoLibrary.shared().register(self)
                self.fetchCanAccessImages()
            case .denied:
                break
            default:
                break
            }
        }
    }
    
    private func fetchCanAccessImages() {
        let option = PHFetchOptions()
        option.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        self.fetchResult = PHAsset.fetchAssets(with: option)
        
        DispatchQueue.main.async {
            self.imageCollectionView.reloadData()
        }
    }
}

extension HeartHubImagePickerViewController: PHPhotoLibraryChangeObserver {
    func photoLibraryDidChange(_ changeInstance: PHChange) {
        DispatchQueue.main.sync {
            if let changes = changeInstance.changeDetails(for: fetchResult) {
                fetchResult = changes.fetchResultAfterChanges
                if changes.hasIncrementalChanges {
                    imageCollectionView.performBatchUpdates({
                        if let removed = changes.removedIndexes, removed.count > 0 {
                            self.imageCollectionView.deleteItems(
                                at: removed.map { IndexPath(item: $0, section:0) }
                            )
                        }
                        if let inserted = changes.insertedIndexes, inserted.count > 0 {
                            self.imageCollectionView.insertItems(
                                at: inserted.map { IndexPath(item: $0, section:0) }
                            )
                        }
                        if let changed = changes.changedIndexes, changed.count > 0 {
                            self.imageCollectionView.reloadItems(
                                at: changed.map { IndexPath(item: $0, section:0) }
                            )
                        }
                        changes.enumerateMoves { fromIndex, toIndex in
                            self.imageCollectionView.moveItem(
                                at: IndexPath(item: fromIndex, section: 0),
                                to: IndexPath(item: toIndex, section: 0)
                            )
                        }
                    })
                } else {
                    imageCollectionView.reloadData()
                }
            }
        }
    }
}

// MARK: UICollectionView Delegate FlowLayout Implementation
extension HeartHubImagePickerViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let width = (view.bounds.width - 6) / 3
        let height = width
        return CGSize(width: width, height: height)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        let afterCell = collectionView.cellForItem(at: indexPath)
        afterCell?.alpha = 0.5
        
        if let beforeCellIndexPath = selectedCellIndexPath {
            let beforeCell = collectionView.cellForItem(at: beforeCellIndexPath)
            beforeCell?.alpha = 1.0
        }
        
        selectedCellIndexPath = indexPath
    }
}

// MARK: - UICollectionView DataSource Implementation
extension HeartHubImagePickerViewController: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return fetchResult.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: HeartHubImagePickerCell.reuseIdentifier,
            for: indexPath
        ) as? HeartHubImagePickerCell else {
            return UICollectionViewCell()
        }
        
        let asset = fetchResult[indexPath.item]
        let requestOptions = PHImageRequestOptions()
        requestOptions.isSynchronous = true
        PHImageManager().requestImage(
            for: asset,
            targetSize: thumbnailSize,
            contentMode: .aspectFill,
            options: requestOptions
        ) { (image, _) in
            cell.imageView.image = image
        }
        
        return cell
    }
}

// MARK: - Configure UI
extension HeartHubImagePickerViewController {
    private func configureSubview() {
        [imageCollectionView].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    private func configureLayout() {
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            imageCollectionView.topAnchor.constraint(
                equalTo: safeArea.topAnchor
            ),
            imageCollectionView.leadingAnchor.constraint(
                equalTo: safeArea.leadingAnchor
            ),
            imageCollectionView.trailingAnchor.constraint(
                equalTo: safeArea.trailingAnchor
            ),
            imageCollectionView.bottomAnchor.constraint(
                equalTo: view.bottomAnchor
            ),
        ])
    }
    
    private func configureImageCollectionView() {
        imageCollectionView.delegate = self
        imageCollectionView.dataSource = self
        imageCollectionView.register(
            HeartHubImagePickerCell.self,
            forCellWithReuseIdentifier: HeartHubImagePickerCell.reuseIdentifier
        )
    }
    
    private func configureNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "확인",
            style: .done,
            target: self,
            action: #selector(tapAddButton)
        )
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: "취소",
            style: .done,
            target: self,
            action: #selector(tapCancelButton)
        )
    }
}

// MARK: - Action Method
extension HeartHubImagePickerViewController {
    @objc
    private func tapAddButton() {
        guard let indexPath = selectedCellIndexPath,
              let cell = imageCollectionView.cellForItem(at: indexPath) as? HeartHubImagePickerCell,
              let image = cell.imageView.image
        else {
            return
        }
        
        delegate?.passSelectedImage(image)
    }
    
    @objc
    private func tapCancelButton() {
        dismiss(animated: true)
    }
}
