//
//  SignUpDateTextField.swift
//  HeartHub
//
//  Created by 이태영 on 2023/09/23.
//

import RxCocoa
import RxSwift
import UIKit

final class SignUpDateTextField: UITextField {
    private let disposeBag = DisposeBag()
    
    // MARK: - initializer
    init(placeholder: String) {
        super.init(frame: .zero)
        configureInitialSettings(with: placeholder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        return false
    }
}

// MARK: - Configure UI
extension SignUpDateTextField {
    private func configureInitialSettings(with placeholder: String) {
        attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [
                NSAttributedString.Key.foregroundColor: UIColor.systemGray,
                NSAttributedString.Key.font: UIFont(name: "Pretendard-Regular", size: 14) ?? UIFont()
            ])
        
        tintColor = .clear
        textColor = .black
        font = UIFont(name: "Pretendard-Regular", size: 14)
        textAlignment = .center
        clipsToBounds = true
        layer.cornerRadius = 18
        layer.borderColor = UIColor.systemGray4.cgColor
        layer.borderWidth = 1
    }
}
