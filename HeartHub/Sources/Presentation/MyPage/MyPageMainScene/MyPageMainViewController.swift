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
    case withdrawal
    case changePassword
    case logout
    
    var title: String {
        switch self {
        case .editProfile:
            return "프로필 수정"
        case .inquiry:
            return "1:1 문의"
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
    
    override func viewDidLoad() {
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
            break
//            navigationController?.pushViewController(ProfileModifyViewController(), animated: true)
        case .inquiry:
            break
        case .withdrawal:
            navigationController?.pushViewController(WithdrawalViewController(), animated: true)
        case .changePassword:
            break
//            navigationController?.pushViewController(PasswordModifyViewController(), animated: true)
        case .logout:
            break
//            let logoutAlert = LogoutAlertViewController()
//            logoutAlert.transitioningDelegate = transitionDelegate
//            logoutAlert.modalPresentationStyle = .custom
//            present(logoutAlert, animated: true)
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

final class CustomAlertPresentationController: UIPresentationController {
    
    private lazy var dimmingView = UIView()
    
    override var frameOfPresentedViewInContainerView: CGRect {
        guard let containerView = containerView else { fatalError("containerView is nil") }
        
        let containerViewBounds = containerView.bounds
        
        var presentedViewFrame: CGRect = .zero
        
        presentedViewFrame.size = size(forChildContentContainer: presentedViewController,
                                       withParentContainerSize: containerViewBounds.size)
        presentedViewFrame.origin.x = (containerViewBounds.size.width - presentedViewFrame.size.width) / 2
        presentedViewFrame.origin.y = (containerViewBounds.size.height - presentedViewFrame.size.height) / 2
        
        return presentedViewFrame
    }
    
    override init(presentedViewController: UIViewController,
                  presenting presentingViewController: UIViewController?) {
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
        configureDimmingView()
    }
    
    override func containerViewWillLayoutSubviews() {
        guard let containerView = containerView else { return }
        presentedView?.frame = frameOfPresentedViewInContainerView
        dimmingView.frame = containerView.bounds
    }
    
    override func size(forChildContentContainer container: UIContentContainer, withParentContainerSize parentSize: CGSize) -> CGSize {
        let defaultAlertWidthMultiplier = 0.725
        let defaultAlertHeightMultiplier = 0.891
      
        return CGSize(width: parentSize.width * defaultAlertWidthMultiplier,
                      height: parentSize.width * defaultAlertHeightMultiplier)
    }
    
}

// MARK: - Presentation Animation

extension CustomAlertPresentationController {
    
    override func presentationTransitionWillBegin() {
        guard let containerView = containerView,
            let transitionCoordinator = presentedViewController.transitionCoordinator,
            let presentedView = presentedView else { fatalError("One of the required views are nil") }
        
        // Dimming view - initial frame
        containerView.insertSubview(dimmingView, at: 0)
        dimmingView.frame = containerView.bounds
        dimmingView.alpha = 0.0
        
        // Presented view - initial frame
        presentedView.layer.cornerRadius = 20
        presentedView.frame = frameOfPresentedViewInContainerView
        
        // Snapshot of presented view for CGAffine animation
        guard let presentedSnapshotView = presentedView.snapshotView(afterScreenUpdates: true) else { return }
        containerView.addSubview(presentedSnapshotView)
        presentedSnapshotView.frame = frameOfPresentedViewInContainerView
        presentedSnapshotView.transform = CGAffineTransform(scaleX: 1.15, y: 1.15)
        presentedSnapshotView.alpha = 0

        presentedView.alpha = 0
        
        transitionCoordinator.animate(
            alongsideTransition: { _ in
                self.dimmingView.alpha = 1.0
                presentedSnapshotView.transform = .identity
                presentedSnapshotView.alpha = 1
        },
            completion: { _ in
                presentedView.alpha = 1.0
                presentedSnapshotView.removeFromSuperview()
        })
    }
}

// MARK: - Dismissal Animation

extension CustomAlertPresentationController {
    
    override func dismissalTransitionWillBegin() {
        guard let transitionCoordinator = presentedViewController.transitionCoordinator else { fatalError("coordinator is nil") }
        
        transitionCoordinator.animate(
            alongsideTransition: { _ in
                self.dimmingView.alpha = 0.0
        },
            completion: { _ in
                self.dimmingView.removeFromSuperview()
        })
    }
    
}

// MARK: - Dimming View configuration

extension CustomAlertPresentationController {
    
    private func configureDimmingView() {
        dimmingView.backgroundColor = UIColor(white: 0.0, alpha: 0.50)
        dimmingView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onDimmingViewTapped)))
    }
    
    @objc func onDimmingViewTapped() {
        presentedViewController.view.endEditing(true)
    }
    
}
