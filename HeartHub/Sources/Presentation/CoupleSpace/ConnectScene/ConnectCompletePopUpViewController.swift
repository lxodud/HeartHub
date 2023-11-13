//
//  ConnectCompleteAlertViewController.swift
//  HeartHub
//
//  Created by 제민우 on 2023/08/15.
//

import UIKit

import RxCocoa
import RxSwift
import UIKit

final class ConnectCompleteAlertViewController: UIViewController {
    private let viewModel: ConnectCheckViewModel
    private let disposeBag = DisposeBag()
    
    private let connectTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "내 애인의 계정이 맞나요?"
        label.numberOfLines = 1
        label.textAlignment = .center
        label.font = UIFont(name: "Pretendard-SemiBold", size: 24)
        label.textColor = .black
        return label
    }()
    
    private let mateProfileImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let mateNicknameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Pretendard-Regular", size: 14)
        label.textColor = .black
        return label
    }()
    
    private let matchingButton: UIButton = {
        let button = UIButton()
        button.setTitle("매칭", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont(name: "Pretendard-Reqular", size: 12)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor(red: 0.98, green: 0.184, blue: 0.741, alpha: 1).cgColor
        button.layer.cornerRadius = 15
        return button
    }()
    
    private let cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle("취소", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont(name: "Pretendard-Reqular", size: 12)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor(red: 0.98, green: 0.184, blue: 0.741, alpha: 1).cgColor
        button.layer.cornerRadius = 15
        return button
    }()
    
    // MARK: - initialzier
    init(viewModel: ConnectCheckViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        configureSuperview()
        configureSubview()
        configureLayout()
        bind(to: viewModel)
    }
    
    private func bind(to viewModel: ConnectCheckViewModel) {
        let viewWillAppear = rx.sentMessage(#selector(UIViewController.viewWillAppear))
            .map { _ in }
            .asDriver(onErrorJustReturn: ())
        let input = ConnectCheckViewModel.Input(
            viewWillAppear: viewWillAppear,
            tapCancel: cancelButton.rx.tap.asDriver(),
            tapMatching: matchingButton.rx.tap.asDriver()
        )
        
        let output = viewModel.transform(input)
        
        output.nickname
            .drive(mateNicknameLabel.rx.text)
            .disposed(by: disposeBag)
        
        output.profileImage
            .drive(onNext: { [weak self] in
                self?.mateProfileImageView.image = UIImage(data: $0)
            })
            .disposed(by: disposeBag)
    }
}

// MARK: Configure UI
extension ConnectCompleteAlertViewController {
    private func configureSuperview() {
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemBackground
        view.layer.cornerRadius = 20
        
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        
        NSLayoutConstraint.activate([
            view.widthAnchor.constraint(
                equalToConstant: screenWidth * 0.8
            ),
            view.heightAnchor.constraint(
                equalToConstant: screenHeight * 0.3
            ),
        ])
    }
    
    private func configureSubview() {
        [connectTitleLabel,
         mateProfileImageView,
         mateNicknameLabel,
         matchingButton,
         cancelButton].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        view.backgroundColor = .systemBackground
    }
    
    private func configureLayout() {
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            // MARK: connectTitleLabel Constraints
            connectTitleLabel.centerXAnchor.constraint(
                equalTo: safeArea.centerXAnchor
            ),
            connectTitleLabel.centerYAnchor.constraint(
                equalTo: safeArea.topAnchor,
                constant: 30
            ),
            
            // MARK: mateProfileImage Constraints
            mateProfileImageView.centerXAnchor.constraint(
                equalTo: safeArea.centerXAnchor
            ),
            mateProfileImageView.centerYAnchor.constraint(
                equalTo: safeArea.centerYAnchor,
                constant: -10
            ),
            
            // MARK: mateUsernameLabel Constraints
            mateNicknameLabel.topAnchor.constraint(
                equalTo: mateProfileImageView.bottomAnchor,
                constant: 10
            ),
            mateNicknameLabel.centerXAnchor.constraint(
                equalTo: safeArea.centerXAnchor
            ),
            
            // MARK: cancelButton Constraints
            cancelButton.heightAnchor.constraint(
                equalTo: safeArea.heightAnchor,
                multiplier: 0.13
            ),
            cancelButton.widthAnchor.constraint(
                equalTo: safeArea.widthAnchor,
                multiplier: 0.2
            ),
            cancelButton.centerXAnchor.constraint(
                equalTo: safeArea.centerXAnchor,
                constant: -70
            ),
            cancelButton.centerYAnchor.constraint(
                equalTo: safeArea.centerYAnchor,
                constant: 85
            ),
            
            // MARK: - matchingButton Constraints
            matchingButton.heightAnchor.constraint(
                equalTo: cancelButton.heightAnchor
            ),
            matchingButton.widthAnchor.constraint(
                equalTo: safeArea.widthAnchor,
                multiplier: 0.2
            ),
            matchingButton.centerXAnchor.constraint(
                equalTo: safeArea.centerXAnchor,
                constant: 70
            ),
            matchingButton.centerYAnchor.constraint(
                equalTo: safeArea.centerYAnchor,
                constant: 85
            )
        ])
    }
}
