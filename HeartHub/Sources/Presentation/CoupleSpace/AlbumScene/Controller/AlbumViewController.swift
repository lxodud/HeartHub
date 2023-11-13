//
//  AlbumViewController.swift.swift
//  HeartHub
//
//  Created by 이태영 on 2023/08/09.
//

import RxCocoa
import RxSwift
import UIKit

final class AlbumViewController: UIViewController {
    private let viewModel: AlbumViewModel
    private let disposeBag = DisposeBag()
    
    private let titleCoupleImageView = CoupleImageBetweenHeartView()
    private let postAlbumButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "WriteArticleButton"), for: .normal)
        return button
    }()
    
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
        label.text = "D + 265"
        label.textColor = .black
        label.font = UIFont(name: "Pretendard-SemiBold", size: 24)
        return label
    }()
    
    private let separateView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.859, green: 0.859, blue: 0.859, alpha: 1)
        return view
    }()
    
    // MARK: - initializer
    init(viewModel: AlbumViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        configureAlbumCollectionView()
        configureSuperview()
        configureSubview()
        configureLayout()
        configureNavigationBar()
        bind(to: viewModel)
    }
    
    private func bind(to viewModel: AlbumViewModel) {
        let viewWillAppear = rx.sentMessage(#selector(UIViewController.viewWillAppear))
            .map { _ in }
            .asDriver(onErrorJustReturn: ())
        
        let input = AlbumViewModel.Input(
            viewWillAppear: viewWillAppear,
            tapPost: postAlbumButton.rx.tap.asDriver()
        )
        
        let output = viewModel.transform(input)
        
        output.album
            .drive(albumCollectionView.rx.items(
                cellIdentifier: AlbumCell.reuseIdentifier,
                cellType: AlbumCell.self)) {_, element, cell in
                    cell.configureCell(with: element)
                }
                .disposed(by: disposeBag)
        
        output.toPost
            .drive()
            .disposed(by: disposeBag)
    }
}

// MARK: UICollectionView Delegate FlowLayout Implementation
extension AlbumViewController: UICollectionViewDelegateFlowLayout {
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

// MARK: Configure UI
extension AlbumViewController {
    private func configureAlbumCollectionView() {
        albumCollectionView.delegate = self
        
        albumCollectionView.register(
            AlbumCell.self,
            forCellWithReuseIdentifier: AlbumCell.reuseIdentifier
        )
    }
    
    private func configureSuperview() {
        view.backgroundColor = .systemBackground
    }
    
    private func configureSubview() {
        [ddayLabel, separateView, albumCollectionView, postAlbumButton].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
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
            postAlbumButton.trailingAnchor.constraint(
                equalTo: safeArea.trailingAnchor,
                constant: -15
            ),
            postAlbumButton.bottomAnchor.constraint(
                equalTo: safeArea.bottomAnchor,
                constant: -15
            ),
        ])
    }
    
    private func configureNavigationBar() {
        let backButton = UIBarButtonItem(
            image: UIImage(systemName: "chevron.left"),
            style: .plain,
            target: self,
            action: #selector(didTapBackButton)
        )
        backButton.tintColor = .black
        navigationItem.leftBarButtonItem = backButton
        navigationItem.titleView = titleCoupleImageView
    }
    
    @objc private func didTapBackButton() {
        navigationController?.popViewController(animated: true)
    }
}

let album1 = UIImage(named: "Album1")!.pngData()!
let album2 = UIImage(named: "Album2")!.pngData()!
let album3 = UIImage(named: "Album3")!.pngData()!
let album4 = UIImage(named: "Album4")!.pngData()!
let album5 = UIImage(named: "Album5")!.pngData()!
