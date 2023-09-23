//
//  SignUpBottomButton.swift
//  HeartHub
//
//  Created by 이태영 on 2023/09/23.
//

import UIKit

final class SignUpBottomButton: UIButton {
    // MARK: - initializer
    init(title: String) {
        super.init(frame: .zero)
        configureInitialSettings(with: title)
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Configure UI
extension SignUpBottomButton {
    private func configureInitialSettings(with title: String) {
        setTitle(title, for: .normal)
        titleLabel?.font = UIFont.init(name: "Pretendard-SemiBold", size: 14)
        setTitleColor(UIColor(red: 0.067, green: 0.067, blue: 0.067, alpha: 1), for: .normal)
        
        let normalColor = UIColor(red: 0.98, green: 0.184, blue: 0.741, alpha: 1)
        setBackgroundColor(normalColor, for: .normal)
        
        layer.cornerRadius = 18
        clipsToBounds = true
    }
    
    private func configureLayout() {
        heightAnchor.constraint(equalToConstant: 60).isActive = true
    }
}
