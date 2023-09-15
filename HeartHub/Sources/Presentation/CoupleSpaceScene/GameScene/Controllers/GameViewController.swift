//
//  CommunityGameViewController.swift
//  HeartHub
//
//  Created by 제민우 on 2023/08/02.
//

import UIKit

final class GameViewController: UIViewController {
    
    private let gamePageViewController: UIViewController? = {
        let pageViewController = GamePageViewController(
            viewControllers: [GameMissionViewController(), GameClearViewController()]
        )
        return pageViewController
    }()
    
    override func loadView() {
        view = GameBackgroundView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSubview()
        configureLayout()
        configureNavigationBar()
    }
}

// MARK: Configure UI
extension GameViewController {
    private func configureSubview() {
        guard let gamePageView = gamePageViewController?.view else {
            return
        }
        view.addSubview(gamePageView)
        gamePageView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configureLayout() {
        guard let gamePageView = gamePageViewController?.view else {
            return
        }
        
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            // MARK: gameButtonStackView Constraints
            gamePageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            gamePageView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 76),
            gamePageView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -101),
            gamePageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
        ])
    }
    
    private func configureNavigationBar() {
        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(didTapBackButton))
        backButton.tintColor = .black
        navigationItem.leftBarButtonItem = backButton
    }
    
    @objc private func didTapBackButton() {
        navigationController?.popViewController(animated: true)
    }
}
