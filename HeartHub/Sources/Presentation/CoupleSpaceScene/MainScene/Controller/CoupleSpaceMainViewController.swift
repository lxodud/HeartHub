//
//  CoupleSpaceMainViewController.swift
//  HeartHub
//
//  Created by 이태영 on 2023/08/02.
//

import UIKit

final class CoupleSpaceMainViewController: UIViewController {
    private let headerView = CoupleSpaceMainHeaderView()
    private let headerBackgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "CoupleSpaceMainBackground")
        return imageView
    }()
    
    private let buttonBackgroundView: UIView = {
        let view = UIView()
        return view
    }()
    
    private let buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 32
        return stackView
    }()
    
    private let albumButton = CoupleSpaceMainButtonView(
        image: UIImage(named: "AlbumButtonImage"),
        title: "Album"
    )
    
    private let pickButton = CoupleSpaceMainButtonView(
        image: UIImage(named: "PickButtonImage"),
        title: "Pick"
    )
    
    private let missionButton = CoupleSpaceMainButtonView(
        image: UIImage(named: "MissionButtonImage"),
        title: "Mission"
    )
    
    private let connectButton = CoupleSpaceMainButtonView(
        image: UIImage(named: "ConnectButtonImage"),
        title: "Connect"
    )
}

// MARK: Life Cycle
extension CoupleSpaceMainViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        configureButtonStack()
        configureSubview()
        configureLayout()
        configureButtonAction()
    }
}

// MARK: Configure Action
extension CoupleSpaceMainViewController {
    private func configureButtonAction() {
        albumButton.addAction(self, #selector(tapAlbumButton))
        pickButton.addAction(self, #selector(tapPickButton))
        missionButton.addAction(self, #selector(tapMissionButton))
        connectButton.addAction(self, #selector(tapConnectButton))
    }
    
    @objc
    private func tapAlbumButton() {
        let coupleSpaceAlbumViewController = CoupleSpaceAlbumViewController()
        navigationController?.pushViewController(coupleSpaceAlbumViewController, animated: true)
    }
    
    @objc
    private func tapPickButton() {
        let coupleSpacePickCollectionViewController = CoupleSpacePickCollectionViewController()
        navigationController?.pushViewController(coupleSpacePickCollectionViewController, animated: true)
    }
    
    @objc
    private func tapMissionButton() {
        let gameViewController = GameViewController()
        navigationController?.pushViewController(gameViewController, animated: true)
    }
    
    @objc
    private func tapConnectButton() {
        let connectViewController = ConnectViewController()
        navigationController?.pushViewController(connectViewController, animated: true)
    }
}

// MARK: Configure UI
extension CoupleSpaceMainViewController {
    private func configureButtonStack() {
        let firstLineHorizontalStackView = UIStackView()
        let secondLineHorizontalStackView = UIStackView()
        
        [albumButton, pickButton].forEach {
            firstLineHorizontalStackView.addArrangedSubview($0)
        }
        
        [missionButton, connectButton].forEach {
            secondLineHorizontalStackView.addArrangedSubview($0)
        }
        
        [firstLineHorizontalStackView, secondLineHorizontalStackView].forEach {
            $0.axis = .horizontal
            $0.alignment = .fill
            $0.distribution = .fillEqually
            $0.spacing = 32
            buttonStackView.addArrangedSubview($0)
        }
    }
    
    private func configureSubview() {
        [headerBackgroundImageView, buttonBackgroundView].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        buttonBackgroundView.addSubview(buttonStackView)
        headerBackgroundImageView.addSubview(headerView)
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        headerView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configureLayout() {
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            // MARK: headerBackgroundImageView Constraints
            headerBackgroundImageView.topAnchor.constraint(
                equalTo: view.topAnchor
            ),
            headerBackgroundImageView.leadingAnchor.constraint(
                equalTo: safeArea.leadingAnchor
            ),
            headerBackgroundImageView.trailingAnchor.constraint(
                equalTo: safeArea.trailingAnchor
            ),
            headerBackgroundImageView.heightAnchor.constraint(
                equalTo: safeArea.heightAnchor,
                multiplier: 0.5
            ),
            
            // MARK: headerView Constraints
            headerView.centerXAnchor.constraint(
                equalTo: safeArea.centerXAnchor
            ),
            headerView.topAnchor.constraint(
                equalTo: view.topAnchor,
                constant: 100
            ),
            headerView.heightAnchor.constraint(
                equalTo: headerBackgroundImageView.heightAnchor,
                multiplier: 0.6
            ),
            headerView.widthAnchor.constraint(
                equalTo: headerBackgroundImageView.widthAnchor,
                multiplier: 0.8
            ),
            
            
            // MARK: buttonBackgroundView Constraints
            buttonBackgroundView.topAnchor.constraint(
                equalTo: headerBackgroundImageView.bottomAnchor
            ),
            buttonBackgroundView.leadingAnchor.constraint(
                equalTo: safeArea.leadingAnchor
            ),
            buttonBackgroundView.trailingAnchor.constraint(
                equalTo: safeArea.trailingAnchor
            ),
            buttonBackgroundView.bottomAnchor.constraint(
                equalTo: safeArea.bottomAnchor
            ),
            
            // MARK: buttonStackView Constraints
            buttonStackView.centerXAnchor.constraint(
                equalTo: buttonBackgroundView.centerXAnchor
            ),
            buttonStackView.centerYAnchor.constraint(
                equalTo: buttonBackgroundView.centerYAnchor
            ),
            buttonStackView.heightAnchor.constraint(
                equalTo: buttonBackgroundView.heightAnchor,
                multiplier: 0.65
            ),
            buttonStackView.widthAnchor.constraint(
                equalTo: buttonBackgroundView.widthAnchor,
                multiplier: 0.7
            ),
            
        ])
    }
}
