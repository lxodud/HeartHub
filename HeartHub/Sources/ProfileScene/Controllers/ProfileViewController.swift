//
//  ProfileViewController.swift
//  HeartHub
//
//  Created by 제민우 on 2023/08/01.
//

import UIKit

final class ProfileViewController: UIViewController {

    private let profileBackgroundView: UIImageView = {
        var imgView = UIImageView()
        imgView.contentMode = .scaleAspectFill
        imgView.image = UIImage(named: "ProfileBackground.png")
        return imgView
    }()
    
    private let profilePageViewController: UIViewController? = {
        let pageViewController = HeartHubPageViewController(
            viewControllers: [ProfileDailyViewController(), ProfileLookViewController(), ProfileDateViewController()]
        )
        return pageViewController
    }()
    
    private var userProfileView = ProfileUserView()
    private var userData = ProfileUserDataModel(
        profileImage: UIImage(named: "TestImage"),
        profileNickName: "하트허브하트허브",
        profileInformaition: "하트허브의 프로필설명란")
    private var userDataManager = ProfileUserDataManager()

    
    private let profileFloatingButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "ReportButton"), for: .normal)
        return button
    }()
    
    private var blockStatus: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUserProfileData()
        configureSubview()
        configureLayout()
        configureFloatingButtonInitialSetting()
        configureFloatingButtonLayout()
    }
}

// MARK: Configure UserProfile Data
extension ProfileViewController {
    private func configureUserProfileData() {
        userDataManager.configureProfileUserData()
        userProfileView.profileImageView.image = userData.profileImage
        userProfileView.profileNickNameLabel.text = userData.profileNickName
        userProfileView.profileInformationLabel.text = userData.profileInformaition
    }
}

// MARK: Configure Floating Button
extension ProfileViewController {
    private func configureFloatingButtonInitialSetting() {
        view.addSubview(profileFloatingButton)
        profileFloatingButton.translatesAutoresizingMaskIntoConstraints = false
        profileFloatingButton.addTarget(self, action: #selector(configureReportAlert), for: .touchUpInside)
    }
    
    private func configureFloatingButtonLayout() {
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            profileFloatingButton.bottomAnchor.constraint(
                equalTo: safeArea.bottomAnchor,
                constant: -21
            ),
            profileFloatingButton.trailingAnchor.constraint(
                equalTo: safeArea.trailingAnchor,
                constant: -21
            )
        ])
    }
}

// MARK: Configure ActionSheet
extension ProfileViewController {
    
    @objc private func configureReportAlert() {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let report = UIAlertAction(title: "신고하기", style: .default) { (action) in
            self.presentReportUserViewController()
        }
        let block = UIAlertAction(title: "차단하기", style: .default) { (action) in
            self.presentBlockUserViewController()
        }
        let cancelBlock = UIAlertAction(title: "차단 해제", style: .default) { (action) in
            self.presentCancelBlockUserViewController()
        }

        let cancel = UIAlertAction(title: "취소", style: .cancel)
                
        alert.addAction(report)
        if blockStatus == true {
            alert.addAction(cancelBlock)
        } else {
            alert.addAction(block)
        }
        alert.addAction(cancel)
                
        present(alert, animated: true, completion: nil)
    }
    
    private func presentReportUserViewController() {
        let reportUserViewController = ProfileReportReasonViewController()
        modalPresentationStyle = .overFullScreen
        present(reportUserViewController, animated: true)
    }
    
    private func presentBlockUserViewController() {
        let blockUserViewController = ProfileBlockUserViewController()
        modalPresentationStyle = .overFullScreen
        present(blockUserViewController, animated: true)
    }
    
    private func presentCancelBlockUserViewController() {
        let profileBlockCancelViewController = ProfileBlockCancelViewController()
        modalPresentationStyle = .overFullScreen
        present(profileBlockCancelViewController, animated: true)
    }
}

// MARK: Configure UI
extension ProfileViewController {
    private func configureSubview() {
        guard let communityPageView = profilePageViewController?.view else {
            return
        }
        [profileBackgroundView,
         userProfileView,
         communityPageView
        ].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    private func configureLayout() {
        
        guard let profilePageView = profilePageViewController?.view else {
            return
        }
        
        let safeArea = view.safeAreaLayoutGuide

        NSLayoutConstraint.activate([
            profileBackgroundView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profileBackgroundView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            profileBackgroundView.topAnchor.constraint(equalTo: view.topAnchor),
            profileBackgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            
            // MARK: userProfileView Constraints
            userProfileView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.32),
            userProfileView.widthAnchor.constraint(equalTo: safeArea.widthAnchor),
            userProfileView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            userProfileView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 69),
            userProfileView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            
            // MARK: profilePageView Constraints
            profilePageView.topAnchor.constraint(
                equalTo: userProfileView.bottomAnchor, constant: 50
            ),
            profilePageView.leadingAnchor.constraint(
                equalTo: safeArea.leadingAnchor
            ),
            profilePageView.trailingAnchor.constraint(
                equalTo: safeArea.trailingAnchor
            ),

            profilePageView.bottomAnchor.constraint(
                equalTo: view.bottomAnchor, constant: 210
            )
        ])
    }
}

