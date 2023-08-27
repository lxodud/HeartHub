//
//  CoupleSpaceAlbumViewController.swift
//  HeartHub
//
//  Created by 이태영 on 2023/08/09.
//

import UIKit

final class CoupleSpaceAlbumViewController: UIViewController {
    private let titleCoupleImageView = CoupleImageBetweenHeartView()
    private let editFloatingButton = HeartHubFloatingButton()
    
    private let albumCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 30
        layout.sectionInset = UIEdgeInsets(top: 30, left: 0, bottom: 0, right: 0)
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout
        )
        return collectionView
    }()
    
    private let ddayLabel: UILabel = {
        let label = UILabel()
        label.text = "D + 0"
        label.textColor = .black
        label.font = UIFont(name: "Pretendard-SemiBold", size: 24)
        return label
    }()
    
    private let separateView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.859, green: 0.859, blue: 0.859, alpha: 1)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureInitialSetting()
        configureAlbumCollectionView()
        configureSubview()
        configureLayout()
        configureNavigationBar()
    }
}

extension CoupleSpaceAlbumViewController: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return 3
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CoupleSpaceAlbumCell.reuseIdentifier,
            for: indexPath
        ) as? CoupleSpaceAlbumCell else {
            return UICollectionViewCell()
        }

        return cell
    }
}

// MARK: UICollectionView Delegate FlowLayout Implementation
extension CoupleSpaceAlbumViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let height = view.bounds.height * 0.6
        let width = view.bounds.width * 0.8
        
        return CGSize(width: width, height: height)
    }
}

extension CoupleSpaceAlbumViewController {
    private func configureInitialSetting() {
        let dDayCalculator = DDayCalculator()
        dDayCalculator.calculateAndDisplayDDay(dayLabel: ddayLabel)
    }
}

// MARK: Configure UI
extension CoupleSpaceAlbumViewController {
    private func configureAlbumCollectionView() {
        albumCollectionView.delegate = self
        albumCollectionView.dataSource = self
        
        albumCollectionView.register(
            CoupleSpaceAlbumCell.self,
            forCellWithReuseIdentifier: CoupleSpaceAlbumCell.reuseIdentifier
        )
    }
    
    private func configureSubview() {
        [ddayLabel, separateView, albumCollectionView, editFloatingButton].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        view.backgroundColor = .systemBackground
    }
    
    private func configureLayout() {
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            // MARK: ddayLabel Constraints
            ddayLabel.topAnchor.constraint(
                equalTo: safeArea.topAnchor,
                constant: 12
            ),
            ddayLabel.centerXAnchor.constraint(
                equalTo: safeArea.centerXAnchor
            ),
            
            // MARK: separateView Constraints
            separateView.topAnchor.constraint(
                equalTo: ddayLabel.bottomAnchor,
                constant: 12
            ),
            separateView.centerXAnchor.constraint(
                equalTo: safeArea.centerXAnchor
            ),
            separateView.widthAnchor.constraint(
                equalTo: safeArea.widthAnchor,
                multiplier: 0.3
            ),
            separateView.heightAnchor.constraint(
                equalToConstant: 1
            ),
            
            // MARK: albumCollectionView Constraints
            albumCollectionView.topAnchor.constraint(
                equalTo: separateView.bottomAnchor,
                constant: 12
            ),
            albumCollectionView.leadingAnchor.constraint(
                equalTo: safeArea.leadingAnchor,
                constant: 15
            ),
            albumCollectionView.trailingAnchor.constraint(
                equalTo: safeArea.trailingAnchor,
                constant: -15
            ),
            albumCollectionView.bottomAnchor.constraint(
                equalTo: view.bottomAnchor
            ),
            
            // MARK: editFloatingButton Constraints
            editFloatingButton.trailingAnchor.constraint(
                equalTo: safeArea.trailingAnchor,
                constant: -15
            ),
            editFloatingButton.bottomAnchor.constraint(
                equalTo: safeArea.bottomAnchor,
                constant: -15
            ),
        ])
    }
    
    private func configureNavigationBar() {
        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(didTapBackButton))
        backButton.tintColor = .black
        navigationItem.leftBarButtonItem = backButton
        navigationItem.titleView = titleCoupleImageView
    }
    
    @objc private func didTapBackButton() {
        navigationController?.popViewController(animated: true)
    }
}
