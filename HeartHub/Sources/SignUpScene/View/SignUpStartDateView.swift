//
//  SignUpView.swift
//  HeartHub
//
//  Created by 제민우 on 2023/07/11.
//

import UIKit

final class SignUpStartDateView: UIView {
    
    private let signUpBackgroundView = SignUpBackgroundView(
        heartImage: "HeartIcon0:3",
        ourStartLabelText: "우리의 시작",
        descriptionLabelText: "당신이 애인과 처음 사귀기 시작한 날은 언제인가요?")
    
    let signUpStartDatePreviousPageButton: UIButton = SignUpChangePageButton(buttonImage: "LeftArrow")
    let signUpStartDateNextPageButton: UIButton = SignUpChangePageButton(buttonImage: "RightArrow")
    
    private lazy var changePageButtonStackView: UIStackView = {
       let stView = UIStackView(arrangedSubviews: [signUpStartDatePreviousPageButton, signUpStartDateNextPageButton])
        stView.axis = .horizontal
        stView.spacing = 198
        stView.distribution = .fillEqually
        stView.alignment = .fill
        return stView
    }()
    
    let startDatePicker = SignUpDatePicker()
    
    let startDateTextField: UITextField = SignUpDateTextField(placeholder: "우리의 시작")
    
    // MARK: 뷰 초기화
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        cofigureInitialSetting()
        configureSubviews()
        configureLayout()
        configureAddTarget()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: Configure InitialSetting
extension SignUpStartDateView {
    
    private func cofigureInitialSetting() {
        backgroundColor = .white
        
        startDateTextField.inputView = startDatePicker

        startDateTextField.delegate = self
        signUpStartDateNextPageButton.isEnabled = false
    }
    
    private func configureAddTarget() {
        startDateTextField.addTarget(self, action: #selector(textFieldEditingChanged(_:)), for: .allEditingEvents)
    }
}

// MARK: Configure Layout
extension SignUpStartDateView {
    private func configureSubviews() {
        [signUpBackgroundView,
         changePageButtonStackView,
         startDateTextField
        ].forEach {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        [signUpStartDatePreviousPageButton, signUpStartDateNextPageButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

    }
    
    // MARK: 제약
    private func configureLayout() {
        let safeArea = safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            
            // MARK: signUpBackgroundView Constraints
            signUpBackgroundView.centerXAnchor.constraint(equalTo: centerXAnchor),
            signUpBackgroundView.centerYAnchor.constraint(equalTo: centerYAnchor),
            signUpBackgroundView.topAnchor.constraint(equalTo: topAnchor),
            signUpBackgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            
            // MARK: startDateStackView Constraints
            startDateTextField.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.04),
            startDateTextField.centerXAnchor.constraint(equalTo: centerXAnchor),
            startDateTextField.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 170),
            startDateTextField.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 50),

            // MARK: changePageButton Constraints
            signUpStartDatePreviousPageButton.heightAnchor.constraint(equalTo: signUpStartDatePreviousPageButton.widthAnchor),
            signUpStartDateNextPageButton.heightAnchor.constraint(equalTo: signUpStartDateNextPageButton.widthAnchor),
            
//            changePageButtonStackView.topAnchor.constraint(equalTo: startDateStackView.bottomAnchor, constant: 225),
            changePageButtonStackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -33),
            changePageButtonStackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 40),
            changePageButtonStackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -40)
        ])
    }
}

// MARK: 텍스트필드 델리게이트
extension SignUpStartDateView: UITextFieldDelegate {
    
    @objc private func textFieldEditingChanged(_ textField: UITextField) {
        if textField.text?.count == 1 {
            if textField.text?.first == " " {
                textField.text = ""
                return
            }
        }
        guard
            let date = startDateTextField.text, date != ""
        else {
            signUpStartDateNextPageButton.isEnabled = false
            return
        }
        signUpStartDateNextPageButton.isEnabled = true
    }
    
    // 엔터누르면 다음 텍스트필드로 이동
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if startDateTextField.text != "" {
            startDateTextField.resignFirstResponder()
            return true
        }
            return false
        }
    
    // 텍스트필드 이외의 영역을 눌렀을때 키보드 내려가도록
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        startDateTextField.resignFirstResponder()
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
        case startDateTextField:
            maxLength = 4
            allowedCharacterSet = CharacterSet(charactersIn: "0123456789")
            let updatedText = (text as NSString).replacingCharacters(in: range, with: string)
            let currentYear = Calendar.current.component(.year, from: Date())
            if let year = Int(updatedText) {
                     if year >= 1950 && year <= currentYear {
                         return true
                     }
                 }
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
}
