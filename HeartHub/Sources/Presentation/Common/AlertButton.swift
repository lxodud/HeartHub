//
//  AlertButton.swift
//  HeartHub
//
//  Created by 제민우 on 2023/08/20.
//

import UIKit

class AlertButton: UIButton {
    private let insets: UIEdgeInsets = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
    
    init(buttonColor: UIColor, borderColor: CGColor?, title: String, titleColor: UIColor) {
        super.init(frame: .zero)
        
        backgroundColor = buttonColor
        layer.borderColor = borderColor
        setTitle(title, for: .normal)
        setTitleColor(titleColor, for: .normal)
        
        configureAlertButton()
        configureLayout()
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = self.frame.height / 2
    }
    
}

extension AlertButton {
    private func configureAlertButton() {
        layer.borderWidth = 1
        
        titleLabel?.font = UIFont(name: "Pretendard-Regular", size: 14)
        titleLabel?.textAlignment = .center
        titleLabel?.numberOfLines = 1
        
        layer.shadowColor = UIColor(red: 0.98, green: 0.184, blue: 0.741, alpha: 0.25).cgColor
        layer.shadowOpacity = 1.0
        layer.shadowOffset = CGSize(width: 0, height: 4)
        layer.shadowRadius = 6
    }
    
    private func configureLayout() {
        
        let safeArea = safeAreaLayoutGuide

        NSLayoutConstraint.activate([
            centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            centerYAnchor.constraint(equalTo: safeArea.centerYAnchor),
            topAnchor.constraint(equalTo: safeArea.topAnchor),
            leadingAnchor.constraint(equalTo: safeArea.leadingAnchor)
        ])
    }
}
