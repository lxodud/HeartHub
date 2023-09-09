//
//  ProfileEditViewController.swift
//  HeartHub
//
//  Created by 이태영 on 2023/09/08.
//

import UIKit

final class ProfileEditViewModel {
    private let userInformationRepository: UserInformationRepository
    
    private var profileImage: Data? {
        didSet {
            profileImageHandler?(profileImage)
        }
    }
    
    var profileImageHandler: ((Data?) -> Void)?
    
    init(userInformationRepository: UserInformationRepository) {
        self.userInformationRepository = userInformationRepository
    }
    
    func fetchProfileImage() {
        profileImage = userInformationRepository.fetchProfileImage()
    }
    
    func editProfile() {
        
    }
}

extension ProfileEditViewModel: HeartHubImagePickerDelegate {
    func passSelectedImage(_ image: Data) {
        profileImage = image
    }
}

final class ProfileEditViewController: UIViewController {
    private let viewModel: ProfileEditViewModel
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
                NSAttributedString.Key.font: UIFont(name: "Pretendard-Regular", size: 20)!
            ]
        )
        
        return textField
    }()
    
    private let descripttionTextField: UITextField = {
        let textField = UITextField()

        textField.font = UIFont(name: "Pretendard-Regular", size: 16)
        textField.textAlignment = .center
        textField.attributedPlaceholder = NSAttributedString(
            string: "소개글을 입력해주세요",
            attributes: [
                NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.07, green: 0.07, blue: 0.07, alpha: 0.5),
                NSAttributedString.Key.font: UIFont(name: "Pretendard-Regular", size: 16)!
            ]
        )
        
        return textField
    }()
    
    private let profileEditButton: UIButton = {
        let button = UIButton()
        let image = UIImage(named: "editProfileButton")
        button.setImage(image, for: .normal)
        button.adjustsImageWhenHighlighted = false
        return button
    }()
    
    init(
        viewModel: ProfileEditViewModel = ProfileEditViewModel(userInformationRepository: UserInformationRepository())
    ) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        configureSubview()
        configureLayout()
        configureAction()
        bind(to: viewModel)
        viewModel.fetchProfileImage()
    }
    
    func bind(to viewModel: ProfileEditViewModel) {
        viewModel.profileImageHandler = { [weak self] imageData in
            guard let imageData = imageData else {
                self?.profileImageView.image = UIImage(named: "basicProfileImage")
                return
            }
            
            self?.profileImageView.image = UIImage(data: imageData)
        }
    }
}

// MARK: Configure Action
extension ProfileEditViewController {
    private func configureAction() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapprofileImageView))
        profileImageView.addGestureRecognizer(tapGesture)
        profileEditButton.addTarget(self, action: #selector(tapProfileEditButton), for: .touchUpInside)
    }
    
    @objc
    private func tapProfileEditButton() {
        // TODO: 프로필 수정 이벤트 전달
    }
    
    @objc
    private func tapprofileImageView() {
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
extension ProfileEditViewController {
    private func configureSubview() {
        [profileImageView, nicknameTextField, descripttionTextField, profileEditButton].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        profileImageView.addSubview(decorateImageView)
        decorateImageView.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemBackground
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
            
            // MARK: decorateImageView Constraints
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
            
            // MARK: nicknameTextField Constraints
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
            
            // MARK: descripttionTextField Constraints
            descripttionTextField.topAnchor.constraint(
                equalTo: nicknameTextField.bottomAnchor,
                constant: 30
            ),
            descripttionTextField.centerXAnchor.constraint(
                equalTo: safeArea.centerXAnchor
            ),
            descripttionTextField.widthAnchor.constraint(
                equalTo: safeArea.widthAnchor,
                multiplier: 0.8
            ),
            
            // MARK: profileEditButton Constraints
            profileEditButton.leadingAnchor.constraint(
                equalTo: safeArea.leadingAnchor,
                constant: 30
            ),
            profileEditButton.trailingAnchor.constraint(
                equalTo: safeArea.trailingAnchor,
                constant: -30
            ),
            profileEditButton.bottomAnchor.constraint(
                equalTo: safeArea.bottomAnchor,
                constant: -20
            ),
        ])
    }
}
