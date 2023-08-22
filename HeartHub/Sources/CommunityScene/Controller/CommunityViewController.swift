//
//  CommunityPageViewController.swift
//  HeartHub
//
//  Created by 이태영 on 2023/07/08.
//

import UIKit

final class CommunityViewController: UIViewController {
    private let communityPageViewController: UIViewController? = {
        let pageViewController = HeartHubPageViewController(
            viewControllers: [DailyDateViewController(), LookViewController(), DailyDateViewController()]
        )
        return pageViewController
    }()
    private let communityFloatingButton = CommunityFloatingButton()
    private let searchBar = UISearchBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCommunityPageViewInitialSetting()
        configureCommunityPageViewLayout()
        configureFloatingButtonInitialSetting()
        configureFloatingButtonLayout()
        configureSearchBarInitialSetting()
    }
}

// MARK: Configure CommunityPageViewController
extension CommunityViewController {
    private func configureCommunityPageViewInitialSetting() {
        guard let communityPageView = communityPageViewController?.view else {
            return
        }
        view.addSubview(communityPageView)
        communityPageView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configureCommunityPageViewLayout() {
        guard let communityPageView = communityPageViewController?.view else {
            return
        }
        
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            communityPageView.topAnchor.constraint(
                equalTo: safeArea.topAnchor
            ),
            communityPageView.leadingAnchor.constraint(
                equalTo: safeArea.leadingAnchor
            ),
            communityPageView.trailingAnchor.constraint(
                equalTo: safeArea.trailingAnchor
            ),
            communityPageView.bottomAnchor.constraint(
                equalTo: safeArea.bottomAnchor
            ),
        ])
    }
}

// MARK: Configure SearchBar
extension CommunityViewController {
    private func configureSearchBarInitialSetting() {
        searchBar.placeholder = "Search your interest!"
        navigationItem.titleView = searchBar
        navigationController?.navigationBar.backgroundColor = .systemBackground
        
        searchBar.barTintColor = #colorLiteral(red: 0.9903513789, green: 0.9556847215, blue: 0.9778354764, alpha: 1)
        
        searchBar.placeholder = "Search your interest!"
        
        //오른쪽 x버튼 이미지 세팅하기
        searchBar.setImage(UIImage(named: "SearchBarImage"), for: UISearchBar.Icon.search, state: .normal)
        
        if let textfield = searchBar.value(forKey: "searchField") as? UITextField {
            //서치바 백그라운드 컬러
            textfield.backgroundColor = #colorLiteral(red: 0.9903513789, green: 0.9556847215, blue: 0.9778354764, alpha: 1)
            //플레이스홀더 글씨 색
            textfield.attributedPlaceholder = NSAttributedString(string: textfield.placeholder ?? "", attributes: [
                NSAttributedString.Key.foregroundColor : UIColor.lightGray,
                NSAttributedString.Key.font: UIFont(name: "Pretendard-Regular", size: 14)!]
            )
            //서치바 텍스트입력시 색 정하기
            textfield.textColor = UIColor.black
            //오른쪽 x버튼 이미지넣기
            if let rightView = textfield.rightView as? UIImageView {
                rightView.image = rightView.image?.withRenderingMode(.alwaysTemplate)
                //이미지 틴트 정하기
                rightView.tintColor = UIColor.lightGray
            }
 
        }
    }
}

// MARK: Configure FloatingButton
extension CommunityViewController {
    private func configureFloatingButtonInitialSetting() {
        view.addSubview(communityFloatingButton)
        communityFloatingButton.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configureFloatingButtonLayout() {
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            communityFloatingButton.bottomAnchor.constraint(
                equalTo: safeArea.bottomAnchor,
                constant: -10
            ),
            communityFloatingButton.trailingAnchor.constraint(
                equalTo: safeArea.trailingAnchor,
                constant: -10
            )
        ])
    }
}
