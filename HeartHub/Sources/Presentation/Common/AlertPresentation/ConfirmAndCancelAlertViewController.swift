//
//  LogoutAlertViewController.swift
//  HeartHub
//
//  Created by 이태영 on 2023/09/14.
//

import UIKit

// TODO: View Model 분리, 코디네이터 구현
final class ConfirmAndCancelAlertViewController: UIViewController {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Pretendard-SemiBold", size: 24)
        label.textAlignment = .center
        return label
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
    
    private let confirmButton: UIButton = {
        let button = UIButton()
        button.setTitle("확인", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont(name: "Pretendard-Reqular", size: 12)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor(red: 0.98, green: 0.184, blue: 0.741, alpha: 1).cgColor
        button.layer.cornerRadius = 15
        return button
    }()
    
    private let confirmButtonAction: (() -> Void)?
    
    // MARK: - initializer
    init(title: String, action: (() -> Void)? = nil) {
        self.confirmButtonAction = action
        super.init(nibName: nil, bundle: nil)
        titleLabel.text = title
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        configureSuperview()
        configureSubview()
        configureLayout()
        configureAction()
    }
}

// MARK: - Configure Action
extension ConfirmAndCancelAlertViewController {
    private func configureAction() {
        cancelButton.addTarget(
            self,
            action: #selector(tapCancelButton),
            for: .touchUpInside
        )
        confirmButton.addTarget(
            self,
            action: #selector(tapConfirmButton),
            for: .touchUpInside
        )
    }
    
    @objc
    private func tapCancelButton() {
        dismiss(animated: true)
    }
    
    @objc
    private func tapConfirmButton() {
        confirmButtonAction?()
        dismiss(animated: true)
    }
}

// MARK: - Configure UI
extension ConfirmAndCancelAlertViewController {
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
        [titleLabel, cancelButton, confirmButton].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    private func configureLayout() {
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            // MARK: - titleLabel Constraints
            titleLabel.centerXAnchor.constraint(
                equalTo: safeArea.centerXAnchor
            ),
            
            titleLabel.centerYAnchor.constraint(
                equalTo: safeArea.centerYAnchor,
                constant: -30
            ),
            
            // MARK: - cancelButton Constraints
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
                constant: -50
            ),
            cancelButton.centerYAnchor.constraint(
                equalTo: safeArea.centerYAnchor,
                constant: 70
            ),
            
            // MARK: - confirmButton Constraints
            confirmButton.heightAnchor.constraint(
                equalTo: titleLabel.heightAnchor
            ),
            confirmButton.widthAnchor.constraint(
                equalTo: safeArea.widthAnchor,
                multiplier: 0.2
            ),
            confirmButton.centerXAnchor.constraint(
                equalTo: safeArea.centerXAnchor,
                constant: 50
            ),
            confirmButton.centerYAnchor.constraint(
                equalTo: safeArea.centerYAnchor,
                constant: 70
            )
        ])
    }
}
