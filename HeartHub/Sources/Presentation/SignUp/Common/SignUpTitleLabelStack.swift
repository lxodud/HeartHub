//
//  SignUpTitleLabelStackView.swift
//  HeartHub
//
//  Created by 이태영 on 2023/09/23.
//

import UIKit

final class SignUpTitleLabelStackView: UIStackView {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Pretendard-SemiBold", size: 20)
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        label.textColor = #colorLiteral(red: 0.07, green: 0.07, blue: 0.07, alpha: 1)
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Pretendard-Regular", size: 14)
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        label.textColor = #colorLiteral(red: 0.46, green: 0.46, blue: 0.46, alpha: 1)
        return label
    }()
    
    // MARK: - initializer
    init(title: String, description: String) {
        super.init(frame: .zero)
        configureInitialSettings(with: title, and: description)
        configureSubview()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Configure UI
extension SignUpTitleLabelStackView {
    private func configureInitialSettings(with title: String, and description: String) {
        titleLabel.text = title
        descriptionLabel.text = description
        
        axis = .vertical
        alignment = .fill
        distribution = .fill
        spacing = 3.5
    }
    
    private func configureSubview() {
        [titleLabel, descriptionLabel].forEach {
            addArrangedSubview($0)
        }
    }
}
