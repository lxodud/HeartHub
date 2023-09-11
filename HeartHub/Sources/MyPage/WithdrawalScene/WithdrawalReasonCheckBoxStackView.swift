//
//  WithdrawalReasonCheckBoxStackView.swift
//  HeartHub
//
//  Created by 이태영 on 2023/09/11.
//

import UIKit

final class WithdrawalReasonCheckBoxStackView: UIStackView {
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0.067, green: 0.067, blue: 0.067, alpha: 1)
        label.font = UIFont(name: "Pretendard-Regular", size: 14)
        return label
    }()
    
    private let checkButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "RadioBtnUnChecked"), for: .normal)
        button.setImage(UIImage(named: "RadioBtnChecked"), for: .selected)
        return button
    }()
    
    init(description: String) {
        super.init(frame: .zero)
        configureInitialSetting()
        configureSubview()
        configureAction()
        descriptionLabel.text = description
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Configure Action
extension WithdrawalReasonCheckBoxStackView {
    private func configureAction() {
        checkButton.addTarget(self, action: #selector(tapCheckButton(_:)), for: .touchUpInside)
    }
    
    @objc
    private func tapCheckButton(_ sender: UIButton) {
        checkButton.isSelected = !sender.isSelected
    }
}

// MARK: - Configure UI
extension WithdrawalReasonCheckBoxStackView {
    private func configureInitialSetting() {
        axis = .horizontal
        alignment = .fill
        distribution = .fill
    }
    
    private func configureSubview() {
        [descriptionLabel, checkButton].forEach {
            addArrangedSubview($0)
        }
        
        descriptionLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
        checkButton.setContentHuggingPriority(.required, for: .horizontal)
    }
}
