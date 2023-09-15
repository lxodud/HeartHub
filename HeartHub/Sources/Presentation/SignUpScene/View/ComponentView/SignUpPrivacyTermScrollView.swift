//
//  SignUpPrivacyTermScrollView.swift
//  HeartHub
//
//  Created by 제민우 on 2023/08/14.
//

import UIKit

final class SignUpPrivacyTermScrollView: UIScrollView {

    private let contentView = UIView()
    
    private let privacyTermMainLabel: UILabel = {
        let label = UILabel()
        label.text = "Heart Hub 개인정보 수집 및 이용 동의"
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        return label
    }()
    
    private let privacyTermLabel: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.numberOfLines = 0
        return label
    }()
    
    init(privacyTermString: String) {
        super.init(frame: .zero)
        privacyTermLabel.text = privacyTermString
        configureSubViews()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Configure Layout
extension SignUpPrivacyTermScrollView {
    
    private func configureSubViews() {
        [privacyTermMainLabel, privacyTermLabel].forEach {
            contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        [contentView].forEach {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    private func configureLayout() {
        NSLayoutConstraint.activate([
            // MARK: ContentView Constraints
            contentView.widthAnchor.constraint(equalTo: widthAnchor),
            contentView.topAnchor.constraint(equalTo: topAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            // MARK: privacyTermMainLabel Constraints
            privacyTermMainLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            privacyTermMainLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            privacyTermMainLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            
            // MARK: privacyTermLabel Constraints
            privacyTermLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            privacyTermLabel.topAnchor.constraint(equalTo: privacyTermMainLabel.bottomAnchor, constant: 26),
            privacyTermLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            privacyTermLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 6),
        ])
    }
}

