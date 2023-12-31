//
//  FindIdAlertViewController.swift
//  HeartHub
//
//  Created by 이태영 on 2023/09/22.
//

import UIKit

final class CancelOnlyAlertViewController: UIViewController {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Pretendard-SemiBold", size: 24)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private let closeButton: UIButton = {
        let button = UIButton()
        button.setTitle("닫기", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor(red: 0.98, green: 0.184, blue: 0.741, alpha: 1).cgColor
        button.layer.cornerRadius = 15
        return button
    }()
    
    private let buttonAction: (() -> Void)?
    
    // MARK: - initializer
    init(title: String, action: (() -> Void)? = nil) {
        self.buttonAction = action
        super.init(nibName: nil, bundle: nil)
        titleLabel.text = title
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        configureAction()
        configureSuperview()
        configureSubview()
        configureLayout()
    }
}

// MARK: - Configure Action
extension CancelOnlyAlertViewController {
    private func configureAction() {
        closeButton.addTarget(
            self,
            action: #selector(tapCloseButton),
            for: .touchUpInside
        )
    }
    
    @objc
    private func tapCloseButton() {
        buttonAction?()
        dismiss(animated: true)
    }
}

// MARK: - Configure UI
extension CancelOnlyAlertViewController {
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
        [titleLabel, closeButton].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    private func configureLayout() {
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            // MARK: - titleLabel Constraints
            titleLabel.widthAnchor.constraint(
                equalTo: safeArea.widthAnchor,
                multiplier: 0.7
            ),
            titleLabel.centerXAnchor.constraint(
                equalTo: safeArea.centerXAnchor
            ),
            
            titleLabel.centerYAnchor.constraint(
                equalTo: safeArea.centerYAnchor,
                constant: -30
            ),
            
            // MARK: - closeButton Constraints
            closeButton.heightAnchor.constraint(
                equalTo: safeArea.heightAnchor,
                multiplier: 0.13
            ),
            closeButton.widthAnchor.constraint(
                equalTo: safeArea.widthAnchor,
                multiplier: 0.6
            ),
            closeButton.centerXAnchor.constraint(
                equalTo: safeArea.centerXAnchor
            ),
            closeButton.centerYAnchor.constraint(
                equalTo: safeArea.centerYAnchor,
                constant: 70
            ),
        ])
    }
}

