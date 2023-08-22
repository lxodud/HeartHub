//
//  ConnectView.swift
//  HeartHub
//
//  Created by 제민우 on 2023/08/15.
//

import UIKit

final class ConnectView: UIView {

    private let connectTextField = SignUpUserInfoTextField(
        placeholder: "내 애인의 아이디를 입력하세요",
        keyboardType: .default,
        isSecureTextEntry: false)
    
    var connectAccountButton: UIButton = {
        let btn = UIButton(type: .custom)
        btn.backgroundColor = .white
        btn.layer.borderWidth = 1
        btn.layer.cornerRadius = 18
        btn.layer.borderColor = #colorLiteral(red: 0.9803773761, green: 0.1853338182, blue: 0.7394250631, alpha: 1)
 
        btn.setTitle("계정 연동하기", for: .normal)
        btn.titleLabel?.font = UIFont.init(name: "Pretendard-Regular", size: 14)
        btn.titleLabel?.textAlignment = .center
        btn.setTitleColor(UIColor(red: 0.067, green: 0.067, blue: 0.067, alpha: 1), for: .normal)
        btn.sizeToFit()
        btn.titleLabel?.adjustsFontSizeToFitWidth = true
        btn.titleLabel?.numberOfLines = 1
        
        btn.layer.shadowColor = UIColor(red: 0.98, green: 0.184, blue: 0.741, alpha: 0.25).cgColor
        btn.layer.shadowOpacity = 1.0
        btn.layer.shadowOffset = CGSize(width: 0, height: 4)
        btn.layer.shadowRadius = 6
        
        
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        configureSubviews()
        configureLayout()
        connectAccountButton.isEnabled = false
        connectTextField.addTarget(self, action: #selector(textFieldEditingChanged(_:)), for: .allEditingEvents)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Configure Layout
extension ConnectView  {

    private func configureSubviews() {
        [connectTextField, connectAccountButton].forEach {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    private func configureLayout() {
        let safeArea = safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            // MARK: connect TextField Constraints
            connectTextField.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.052),
            connectTextField.centerYAnchor.constraint(equalTo: centerYAnchor),
            connectTextField.centerXAnchor.constraint(equalTo: centerXAnchor),
            connectTextField.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 30),
            
            // MARK: connect TextField Constraints
            connectAccountButton.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.09),
            connectAccountButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            connectAccountButton.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -24),
            connectAccountButton.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 30)
        ])
    }
}

// MARK: TextField Delegate Implement
extension ConnectView: UITextFieldDelegate  {
    // 키보드 엔터키가 눌렸을때 (다음 동작을 허락할 것인지)
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // 두개의 텍스트필드를 모두 종료 (키보드 내려가기)
        if connectTextField.text != "" {
            connectTextField.resignFirstResponder()
            return true
        }
            return false
        }
    
    // 텍스트필드 이외의 영역을 눌렀을때 키보드 내려가도록
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        connectTextField.resignFirstResponder()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
      
        // 백스페이스 감지
        if let char = string.cString(using: String.Encoding.utf8) {
            let isBackSpace = strcmp(char, "\\b")
            if isBackSpace == -92 {
                return true
            }
        }
        
        guard let text = textField.text else {
            return true
        }
        
        let maxLength: Int
        var allowedCharacterSet: CharacterSet
        
        switch textField {
        case connectTextField:
            maxLength = 10
            allowedCharacterSet = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#$%^&*()-_?+=~")
                .union(CharacterSet(charactersIn: "\u{AC00}"..."\u{D7A3}"))
                .union(CharacterSet(charactersIn: "\u{3131}"..."\u{314E}"))
                .union(CharacterSet(charactersIn: "\u{314F}"..."\u{3163}"))
        default:
            return true
        }
        
        let newLength = text.count + string.count - range.length
        
        if newLength <= maxLength {
            let characterSet = CharacterSet(charactersIn: string)
            return allowedCharacterSet.isSuperset(of: characterSet)
        } else {
            return false
        }
    }
    
    @objc private func textFieldEditingChanged(_ textField: UITextField) {
        if textField.text?.count == 1 {
            if textField.text?.first == " " {
                textField.text = ""
                return
            }
        }
        guard
            let id = connectTextField.text, id != ""
        else {
            connectAccountButton.isEnabled = false
            return
        }
        connectAccountButton.isEnabled = true
    }
}
