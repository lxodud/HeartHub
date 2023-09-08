//
//  CoupleSpacePickCollectionViewController.swift
//  HeartHub
//
//  Created by 이태영 on 2023/08/03.
//

import UIKit

private enum Constant {
    static let myPickImage = UIImage(named: "MyPickButton")
    static let heartPickImage = UIImage(named: "HeartPickButton")
}

final class CoupleSpacePickCollectionViewController: UIViewController {
    private var pickCollectionDataSource: CoupleSpacePickDataSourceable {
        didSet {
            configureNavigationBar()
            pickCollectionView.dataSource = pickCollectionDataSource
            pickCollectionView.reloadData()
        }
    }
    
    private let pickCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout
        )
        return collectionView
    }()
    
    private let myPickTransitionButton: UIButton = {
        let button = UIButton()
        button.setImage(Constant.myPickImage, for: .normal)
        button.isHidden = true
        return button
    }()
    
    private let heartPickTransitionButton: UIButton = {
        let button = UIButton()
        button.setImage(Constant.heartPickImage, for: .normal)
        return button
    }()
    
    init(pickCollectionDataSource: CoupleSpacePickDataSourceable = HeartPickDataSource()) {
        self.pickCollectionDataSource = pickCollectionDataSource
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Life Cycle
extension CoupleSpacePickCollectionViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        configureAction()
        configurePickCollectionView()
        configureSubview()
        configureLayout()
        configureNavigationBar()
    }
}

// MARK: UICollectionView Delegate FlowLayout Implementation
extension CoupleSpacePickCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let width = view.frame.width / 2
        let height = width
        
        return CGSize(width: width, height: height)
    }
}

// MARK: Configure pickCollectionView
extension CoupleSpacePickCollectionViewController {
    private func configurePickCollectionView() {
        pickCollectionView.delegate = self
        pickCollectionView.dataSource = pickCollectionDataSource
    }
}

// MARK: Configure UI
extension CoupleSpacePickCollectionViewController {
    private func configureSubview() {
        [pickCollectionView, myPickTransitionButton, heartPickTransitionButton].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        view.backgroundColor = .systemBackground
    }
    
    private func configureLayout() {
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            // MARK: pickCollectionView Constraints
            pickCollectionView.topAnchor.constraint(
                equalTo: safeArea.topAnchor
            ),
            pickCollectionView.leadingAnchor.constraint(
                equalTo: safeArea.leadingAnchor
            ),
            pickCollectionView.trailingAnchor.constraint(
                equalTo: safeArea.trailingAnchor
            ),
            pickCollectionView.bottomAnchor.constraint(
                equalTo: view.bottomAnchor
            ),
            
            // MARK: pickTransitionButton Constraints
            myPickTransitionButton.trailingAnchor.constraint(
                equalTo: safeArea.trailingAnchor,
                constant: -21
            ),
            myPickTransitionButton.bottomAnchor.constraint(
                equalTo: safeArea.bottomAnchor,
                constant: -21
            ),
            
            // MARK: heartPickTransitionButton Constraints
            heartPickTransitionButton.trailingAnchor.constraint(
                equalTo: safeArea.trailingAnchor,
                constant: -21
            ),
            heartPickTransitionButton.bottomAnchor.constraint(
                equalTo: safeArea.bottomAnchor,
                constant: -21
            ),
        ])
    }
    
    private func configureNavigationBar() {
        let backButton = UIBarButtonItem(
            image: UIImage(systemName: "chevron.left"),
            style: .plain, target: self,
            action: #selector(didTapBackButton)
        )
        backButton.tintColor = .black
        navigationItem.leftBarButtonItem = backButton
        navigationItem.title = pickCollectionDataSource.fetchTitle()
    }
}

// MARK: Action Method
extension CoupleSpacePickCollectionViewController {
    private func configureAction() {
        myPickTransitionButton.addTarget(
            self,
            action: #selector(tapMyPickTransitionButton),
            for: .touchUpInside
        )
        heartPickTransitionButton.addTarget(
            self,
            action: #selector(tapHeartPickTransitionButton),
            for: .touchUpInside
        )
    }
    
    @objc
    private func tapMyPickTransitionButton(_ sender: UIButton) {
        sender.isHidden = true
        heartPickTransitionButton.isHidden = false
        pickCollectionDataSource = HeartPickDataSource()
    }
    
    @objc
    private func tapHeartPickTransitionButton(_ sender: UIButton) {
        sender.isHidden = true
        myPickTransitionButton.isHidden = false
        pickCollectionDataSource = MyPickDataSource()
    }
    
    @objc
    private func didTapBackButton() {
        navigationController?.popViewController(animated: true)
    }
}
