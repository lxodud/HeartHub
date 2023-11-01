//
//  MyPageMainViewController.swift
//  HeartHub
//
//  Created by 이태영 on 2023/08/28.
//

import RxCocoa
import RxSwift
import UIKit

final class MyPageMainViewController: UIViewController {
    private let viewModel: MyPageMainViewModel
    private let disposeBag = DisposeBag()
    
    private let transitionDelegate = AlertTransitionDelegate()
    private let menuTableView = UITableView()
    private let profileImageView: UIImageView = {
        let imageView = HeartHubProfileImageView()
        imageView.image = UIImage(named: "basicProfileImage")
        return imageView
    }()
    private let nicknameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Pretendard-Medium", size: 16)
        label.text = "하모"
        label.textAlignment = .center
        return label
    }()
    
    // MARK: - initializer
    init(viewModel: MyPageMainViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        configureTableView()
        configureSubview()
        configureLayout()
        bind(to: viewModel)
    }
    
    private func bind(to viewModel: MyPageMainViewModel) {
        let cellSelected = menuTableView.rx.itemSelected.asDriver()
        let input = MyPageMainViewModel.Input(
            cellSelected: cellSelected
        )
        
        let output = viewModel.transform(input)
        
        output.menu
            .drive(menuTableView.rx.items(
                cellIdentifier: MyPageCell.reuseIdentifier,
                cellType: MyPageCell.self)) {_, element, cell in
                    cell.titleLabel.text = element.title
                }
                .disposed(by: disposeBag)
        
        output.toNext
            .drive()
            .disposed(by: disposeBag)
    }
}

// MARK: - Configure UI
extension MyPageMainViewController {
    private func configureTableView() {
        menuTableView.isScrollEnabled = false
        menuTableView.register(MyPageCell.self, forCellReuseIdentifier: MyPageCell.reuseIdentifier)
    }
    
    private func configureSubview() {
        [profileImageView, nicknameLabel, menuTableView].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    private func configureLayout() {
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            // MARK: - profileImageView Constraints
            profileImageView.topAnchor.constraint(
                equalTo: safeArea.topAnchor,
                constant: 50
            ),
            profileImageView.centerXAnchor.constraint(
                equalTo: safeArea.centerXAnchor
            ),
            profileImageView.widthAnchor.constraint(
                equalTo: safeArea.widthAnchor,
                multiplier: 0.2
            ),profileImageView.heightAnchor.constraint(
                equalTo: profileImageView.widthAnchor
            ),
            
            // MARK: - nicknameLabel Constraints
            nicknameLabel.centerXAnchor.constraint(
                equalTo: safeArea.centerXAnchor
            ),
            nicknameLabel.topAnchor.constraint(
                equalTo: profileImageView.bottomAnchor
            ),
            
            // MARK: - menuTableView Constraints
            menuTableView.topAnchor.constraint(
                equalTo: nicknameLabel.bottomAnchor,
                constant: 100
            ),
            menuTableView.leadingAnchor.constraint(
                equalTo: safeArea.leadingAnchor
            ),
            menuTableView.trailingAnchor.constraint(
                equalTo: safeArea.trailingAnchor
            ),
            menuTableView.bottomAnchor.constraint(
                equalTo: safeArea.bottomAnchor
            )
        ])
    }
}
