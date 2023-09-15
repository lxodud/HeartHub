//
//  SignUpTermOfUseScrollView.swift
//  HeartHub
//
//  Created by 제민우 on 2023/08/14.
//

import UIKit

final class SignUpTermOfUseScrollView: UIScrollView {
    private let contentView = UIView()
    
    private let termOfUseMainLabel: UILabel = {
        let label = UILabel()
        label.text = "Heart Hub 서비스 이용 약관"
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        return label
    }()
    
    private let termOfUseLabel: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.numberOfLines = 0
        return label
    }()
    
    init(termOfUseString: String) {
        super.init(frame: .zero)
        configureSubViews()
        configureLayout()
        termOfUseLabel.text = termOfUseString
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Configure Layout
extension SignUpTermOfUseScrollView {
    
    private func configureSubViews() {
        [termOfUseMainLabel, termOfUseLabel].forEach {
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
            
            // MARK: termOfUseMainLabel Constraints
            termOfUseMainLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            termOfUseMainLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            termOfUseMainLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            
            // MARK: termOfUseLabel Constraints
            termOfUseLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            termOfUseLabel.topAnchor.constraint(equalTo: termOfUseMainLabel.bottomAnchor, constant: 26),
            termOfUseLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            termOfUseLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 6),
        ])
    }
}
