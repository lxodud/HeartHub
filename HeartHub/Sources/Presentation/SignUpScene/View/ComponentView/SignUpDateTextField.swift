//
//  SignUpBirthDateTextFieldView.swift
//  HeartHub
//
//  Created by 제민우 on 2023/08/07.
//

import UIKit

final class SignUpDateTextField: UITextField {
    
    private let insets: UIEdgeInsets = UIEdgeInsets(top: 6, left: 22, bottom: 6, right: 22)
    
    init(placeholder: String) {
        super.init(frame: .zero)
        
        attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.07, green: 0.07, blue: 0.07, alpha: 0.5),
                         NSAttributedString.Key.font: UIFont(name: "Pretendard-Regular", size: 14)!
                        ])
        
        configureDateTextField()
        configureLayout()
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: insets)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: insets)
    }
}

// MARK: Configure TextField
extension SignUpDateTextField {
    private func configureDateTextField() {
        backgroundColor = .clear
        textColor = #colorLiteral(red: 0.07, green: 0.07, blue: 0.07, alpha: 0.5)
        keyboardType = .numberPad
        textAlignment = .center
        font = UIFont(name: "Pretendard-Regular", size: 14)

        clipsToBounds = true
        layer.cornerRadius = 18
        layer.borderColor = #colorLiteral(red: 0.86, green: 0.86, blue: 0.86, alpha: 1)
        layer.borderWidth = 1
    }
}

// MARK: Configure Layout
extension SignUpDateTextField {
    
    private func configureLayout() {
        let safeArea = safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            // MARK: signUpYearTextField Constraints
            centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            centerYAnchor.constraint(equalTo: safeArea.centerYAnchor),
            topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 7),
            leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 21)
        ])
    }
}
