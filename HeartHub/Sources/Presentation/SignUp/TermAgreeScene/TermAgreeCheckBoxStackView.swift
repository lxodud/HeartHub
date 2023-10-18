//
//  TermAgreeCheckBoxStackView.swift
//  HeartHub
//
//  Created by 이태영 on 2023/10/10.
//

import UIKit

final class TermAgreeCheckBoxStackView: UIStackView {
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0.067, green: 0.067, blue: 0.067, alpha: 1)
        label.font = UIFont(name: "Pretendard-Regular", size: 16)
        return label
    }()
    
    let checkButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "RadioButtonUnChecked"), for: .normal)
        button.setImage(UIImage(named: "RadioButtonChecked"), for: .selected)
        return button
    }()
    
    init(description: String) {
        super.init(frame: .zero)
        configureInitialSetting()
        configureSubview()
        descriptionLabel.text = description
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Configure UI
extension TermAgreeCheckBoxStackView {
    private func configureInitialSetting() {
        axis = .horizontal
        alignment = .fill
        distribution = .fill
        spacing = 10
    }
    
    private func configureSubview() {
        [checkButton, descriptionLabel].forEach {
            addArrangedSubview($0)
        }
        
        descriptionLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
        checkButton.setContentHuggingPriority(.required, for: .horizontal)
    }
}

