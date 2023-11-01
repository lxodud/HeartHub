//
//  ProfileModifyViewController.swift
//  HeartHub
//
//  Created by 이태영 on 2023/09/08.
//

import RxCocoa
import RxSwift
import UIKit

final class ProfileModifyViewController: UIViewController {
    private let viewModel: ProfileModifyViewModel
    private let disposeBag = DisposeBag()
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.isUserInteractionEnabled = true
        imageView.layer.cornerRadius = 20
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let decorateImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "profileImageCamera")
        return imageView
    }()
    
    private let nicknameTextField: UITextField = {
        let textField = UITextField()
        textField.font = UIFont(name: "Pretendard-Regular", size: 20)
        textField.textAlignment = .center
        textField.attributedPlaceholder = NSAttributedString(
            string: "닉네임을 작성해주세요",
            attributes: [
                NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.07, green: 0.07, blue: 0.07, alpha: 0.5),
                NSAttributedString.Key.font: UIFont(name: "Pretendard-Regular", size: 20) ?? UIFont()
            ]
        )
        
        return textField
    }()
    
    private let profileModifyButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("프로필로 적용하기", for: .normal)
        button.titleLabel?.font = UIFont.init(name: "Pretendard-Regular", size: 14)
        button.setTitleColor(UIColor(red: 0.067, green: 0.067, blue: 0.067, alpha: 1), for: .normal)
        button.setTitleColor(.systemGray, for: .disabled)
        
        let normalColor = UIColor(red: 0.98, green: 0.184, blue: 0.741, alpha: 1)
        button.setBackgroundColor(normalColor, for: .normal)
        
        button.layer.cornerRadius = 18
        button.clipsToBounds = true
        
        return button
    }()
    
    private let activityIndicator = UIActivityIndicatorView()
    
    // MARK: - initializer
    init(viewModel: ProfileModifyViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        configureSubview()
        configureLayout()
        configureNavigationBar()
        bind(to: viewModel)
    }

    private func bind(to viewModel: ProfileModifyViewModel) {
        let viewWillAppear = rx.sentMessage(#selector(UIViewController.viewWillAppear(_:)))
            .map { _ in }
            .asDriver(onErrorJustReturn: ())
        
        let input = ProfileModifyViewModel.Input(
            newNickname: nicknameTextField.rx.text.orEmpty.asDriver(),
            viewWillAppear: viewWillAppear
        )
        
        let output = viewModel.transform(input)
        
        output.profileImage
            .map { UIImage(data: $0) }
            .drive(profileImageView.rx.image)
            .disposed(by: disposeBag)
        
        output.verifiedNewNickname
            .drive(nicknameTextField.rx.text)
            .disposed(by: disposeBag)
        
        output.initialNicknameAndImage
            .map { $0.nickname }
            .drive(nicknameTextField.rx.text)
            .disposed(by: disposeBag)
        
        output.initialNicknameAndImage
            .map {
                UIImage(data: $0.profileImage) == nil ? UIImage(named: "basicProfileImage") : UIImage(data: $0.profileImage)
            }
            .drive(profileImageView.rx.image)
            .disposed(by: disposeBag)
    }
}

// MARK: - Configure Action
extension ProfileModifyViewController {
    private func tapProfileImageView() {
        let imagePickerViewController = HeartHubImagePickerViewController()
        imagePickerViewController.delegate = viewModel
        let imagePickerNavigationViewController = UINavigationController(
            rootViewController: imagePickerViewController
        )
        imagePickerNavigationViewController.modalPresentationStyle = .fullScreen
        navigationController?.present(imagePickerNavigationViewController, animated: true)
    }
}

// MARK: - Configure UI
extension ProfileModifyViewController {
    private func configureSuperview() {
        view.backgroundColor = .systemBackground
    }
    
    private func configureSubview() {
        [profileImageView, nicknameTextField, profileModifyButton, activityIndicator].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        profileImageView.addSubview(decorateImageView)
        decorateImageView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configureLayout() {
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            // MARK: - profileImageView Constraints
            profileImageView.topAnchor.constraint(
                equalTo: safeArea.topAnchor,
                constant: 30
            ),
            profileImageView.centerXAnchor.constraint(
                equalTo: safeArea.centerXAnchor
            ),
            profileImageView.heightAnchor.constraint(
                equalTo: safeArea.heightAnchor,
                multiplier: 0.25
            ),
            profileImageView.widthAnchor.constraint(
                equalTo: profileImageView.heightAnchor
            ),
            
            // MARK: - decorateImageView Constraints
            decorateImageView.trailingAnchor.constraint(
                equalTo: profileImageView.trailingAnchor,
                constant: -10
            ),
            decorateImageView.bottomAnchor.constraint(
                equalTo: profileImageView.bottomAnchor,
                constant: -10
            ),
            decorateImageView.heightAnchor.constraint(
                equalTo: profileImageView.heightAnchor,
                multiplier: 0.15
            ),
            decorateImageView.widthAnchor.constraint(
                equalTo: decorateImageView.heightAnchor
            ),
            
            // MARK: - nicknameTextField Constraints
            nicknameTextField.topAnchor.constraint(
                equalTo: profileImageView.bottomAnchor,
                constant: 30
            ),
            nicknameTextField.centerXAnchor.constraint(
                equalTo: safeArea.centerXAnchor
            ),
            nicknameTextField.widthAnchor.constraint(
                equalTo: safeArea.widthAnchor,
                multiplier: 0.7
            ),
            
            // MARK: - profileEditButton Constraints
            profileModifyButton.leadingAnchor.constraint(
                equalTo: safeArea.leadingAnchor,
                constant: 30
            ),
            profileModifyButton.trailingAnchor.constraint(
                equalTo: safeArea.trailingAnchor,
                constant: -30
            ),
            profileModifyButton.bottomAnchor.constraint(
                equalTo: safeArea.bottomAnchor,
                constant: -20
            ),
            profileModifyButton.heightAnchor.constraint(
                equalTo: safeArea.heightAnchor,
                multiplier: 0.08
            ),
            
            // MARK: - activiryIndicator Constraints
            activityIndicator.centerXAnchor.constraint(
                equalTo: safeArea.centerXAnchor
            ),
            activityIndicator.centerYAnchor.constraint(
                equalTo: safeArea.centerYAnchor
            )
        ])
    }
    
    private func configureNavigationBar() {
        navigationItem.title = "프로필 수정"
    }
}
