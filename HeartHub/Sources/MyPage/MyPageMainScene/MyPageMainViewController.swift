//
//  MyPageMainViewController.swift
//  HeartHub
//
//  Created by 이태영 on 2023/08/28.
//

import UIKit

enum MyPageRow: Int, CaseIterable {
    case editProfile = 0
    case inquiry
    case notificationSettings
    case withdrawal
    case changePassword
    case logout
    
    var title: String {
        switch self {
        case .editProfile:
            return "프로필 수정"
        case .inquiry:
            return "1:1 문의"
        case .notificationSettings:
            return "알림설정"
        case .withdrawal:
            return "회원탈퇴"
        case .changePassword:
            return "비밀번호 변경"
        case .logout:
            return "로그아웃"
        }
    }
}

final class MyPageMainViewController: UIViewController {
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        configureSubview()
        configureLayout()
    }
}

// MARK: - UITableView Delegate Implementation
extension MyPageMainViewController: UITableViewDelegate {
    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        guard let row = MyPageRow(rawValue: indexPath.row) else {
            return
        }
        
        switch row {
        case .editProfile:
            navigationController?.pushViewController(ProfileModifyViewController(), animated: true)
        case .inquiry:
            break
        case .notificationSettings:
            break
        case .withdrawal:
            break
        case .changePassword:
            break
        case .logout:
            break
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - UITableView DataSource Implementation
extension MyPageMainViewController: UITableViewDataSource {
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return MyPageRow.allCases.count
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: MyPageCell.reuseIdentifier,
            for: indexPath
        ) as? MyPageCell else {
            return UITableViewCell()
        }
        
        cell.titleLabel.text = MyPageRow.allCases[indexPath.row].title
        
        return cell
    }
}

// MARK: - Configure UI
extension MyPageMainViewController {
    private func configureTableView() {
        menuTableView.dataSource = self
        menuTableView.delegate = self
        menuTableView.register(
            MyPageCell.self,
            forCellReuseIdentifier: MyPageCell.reuseIdentifier
        )
        menuTableView.isScrollEnabled = false
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
