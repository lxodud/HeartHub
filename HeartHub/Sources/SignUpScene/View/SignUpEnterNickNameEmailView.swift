//
//  SignUp3View.swift
//  HeartHub
//
//  Created by 제민우 on 2023/07/11.
//

import UIKit

final class SignUpEnterNickNameEmailView: UIView {
    
    private let signUpBackgroundView = SignUpBackgroundView(
        heartImage: "HeartIcon2:3",
        ourStartLabelText: "사랑을 시작해볼까요?",
        descriptionLabelText: "계정을 생성하여 HeartHuB를 즐겨보아요.")
    
    let nickNameTextField = SignUpUserInfoTextField(
        placeholder: "닉네임을 입력해주세요.",
        keyboardType: .default,
        isSecureTextEntry: false
    )
    
    var nickNameDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "한글/영문/숫자/특수문자 구성"
        label.font = UIFont(name: "Pretendard-Regular", size: 12)
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        label.textColor = #colorLiteral(red: 0.46, green: 0.46, blue: 0.46, alpha: 1)
        return label
    }()
    
    var nickNameCheckButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = #colorLiteral(red: 0.8588235378, green: 0.8588235378, blue: 0.8588235378, alpha: 1)
        button.setTitle("중복 확인", for: .normal)
        button.setTitleColor(UIColor(red: 0.46, green: 0.46, blue: 0.46, alpha: 1), for: .normal)
        button.titleLabel?.font = UIFont(name: "Pretendard-Regular", size: 14)
        button.titleLabel?.contentMode = .scaleAspectFill
        button.clipsToBounds = true
        button.layer.cornerRadius = 18
        button.contentMode = .center
        button.tintColor = .black
        return button
    }()
    
    // MARK: 이메일 입력 + dropDown 버튼
    // 이메일 입력 텍스트 필드
    var emailTextField = SignUpUserInfoTextField(
        placeholder: "이메일을 입력해주세요",
        keyboardType: .emailAddress,
        isSecureTextEntry: false)
    
    var emailVerifyButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = #colorLiteral(red: 0.8588235378, green: 0.8588235378, blue: 0.8588235378, alpha: 1)
        button.setTitle("인증", for: .normal)
        button.setTitleColor(UIColor(red: 0.46, green: 0.46, blue: 0.46, alpha: 1), for: .normal)
        button.titleLabel?.font = UIFont(name: "Pretendard-Regular", size: 14)
        button.titleLabel?.contentMode = .scaleAspectFill
        button.clipsToBounds = true
        button.layer.cornerRadius = 18
        button.contentMode = .center
        button.tintColor = .black
        return button
    }()
    
    // 이메일 형식 제약조건 레이블
    private lazy var emailFormatDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "이메일의 형식이 올바르지 않습니다."
        label.font = UIFont(name: "Pretendard-Regular", size: 12)
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        label.isHidden = true
        label.textColor = #colorLiteral(red: 1, green: 0.01488391776, blue: 0.006827606354, alpha: 1)
        return label
    }()
    
    // 닉네임, 이메일 입력 스택뷰
    private lazy var enterStackView: UIStackView = {
        let stView = UIStackView(arrangedSubviews: [nickNameTextField, emailTextField])
        stView.spacing = 36
        stView.axis = .vertical
        stView.distribution = .fillEqually
        stView.alignment = .fill
        return stView
    }()
    
    let signUpLoverPreviousPageButton = SignUpChangePageButton(buttonImage: "LeftArrow")
    let signUpLoverNextPageButton = SignUpChangePageButton(buttonImage: "RightArrow")
    
    private lazy var changePageButtonStackView: UIStackView = {
        let stView = UIStackView(arrangedSubviews: [signUpLoverPreviousPageButton, signUpLoverNextPageButton])
        stView.axis = .horizontal
        stView.spacing = 198
        stView.distribution = .fillEqually
        stView.alignment = .fill
        return stView
    }()
    
    // MARK: 뷰 초기화
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureSubViews()
        configureLayout()
        configureInitialSetting()
        configureAddTarget()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Configure InitialSetting
extension SignUpEnterNickNameEmailView {
    
    private func configureInitialSetting() {
        backgroundColor = .white
        
        emailTextField.delegate = self
        nickNameTextField.delegate = self
        nickNameTextField.delegate = self
        
        signUpLoverNextPageButton.isEnabled = false
    }
    
    private func configureAddTarget() {
        [nickNameTextField, emailTextField].forEach {
            $0.addTarget(self, action: #selector(textFieldEditingChanged(_:)), for: .editingChanged)
        }
    }
}

// MARK: Configure Layout
extension SignUpEnterNickNameEmailView {
    func configureSubViews() {
        nickNameTextField.addSubview(nickNameCheckButton)
        emailTextField.addSubview(emailVerifyButton)
        
        [signUpBackgroundView,
         enterStackView,
         nickNameDescriptionLabel,
         emailFormatDescriptionLabel,
         changePageButtonStackView,].forEach{
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        [nickNameTextField,
         emailTextField,
         nickNameCheckButton,
         emailVerifyButton,
         signUpLoverPreviousPageButton,
         signUpLoverNextPageButton
        ].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
    }
    
    private func configureLayout() {
        let safeArea = safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            
            // MARK: signUpBackgroundView Constraints
            signUpBackgroundView.centerXAnchor.constraint(equalTo: centerXAnchor),
            signUpBackgroundView.centerYAnchor.constraint(equalTo: centerYAnchor),
            signUpBackgroundView.topAnchor.constraint(equalTo: topAnchor),
            signUpBackgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            
            // MARK: enterStackView Constraints
            enterStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            enterStackView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 170),
            enterStackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 30),
            
            nickNameTextField.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.04),
            
            emailTextField.heightAnchor.constraint(equalTo: nickNameTextField.heightAnchor),
            
            nickNameCheckButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.19),
            nickNameCheckButton.topAnchor.constraint(equalTo: nickNameTextField.topAnchor),
            nickNameCheckButton.bottomAnchor.constraint(equalTo: nickNameTextField.bottomAnchor),
            nickNameCheckButton.trailingAnchor.constraint(equalTo: nickNameTextField.trailingAnchor),

            // MARK: nickNameDescriptionLabel Constraints
            nickNameDescriptionLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.02),
            nickNameDescriptionLabel.topAnchor.constraint(equalTo: nickNameTextField.bottomAnchor, constant: 3),
            nickNameDescriptionLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 42),
            
            // MARK: emailFormatDescriptionLabel Constraints
            emailFormatDescriptionLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.02),
            emailFormatDescriptionLabel.topAnchor.constraint(equalTo: emailTextField.bottomAnchor),
            emailFormatDescriptionLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 46),

            // MARK: dropDownBtn Constraints
            emailVerifyButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.19),
            emailVerifyButton.topAnchor.constraint(equalTo: emailTextField.topAnchor),
            emailVerifyButton.bottomAnchor.constraint(equalTo: emailTextField.bottomAnchor),
            emailVerifyButton.trailingAnchor.constraint(equalTo: emailTextField.trailingAnchor),
            
            // MARK: changePageButton Constraints
            signUpLoverPreviousPageButton.heightAnchor.constraint(equalTo: signUpLoverPreviousPageButton.widthAnchor),
            signUpLoverNextPageButton.heightAnchor.constraint(equalTo: signUpLoverNextPageButton.widthAnchor),
            changePageButtonStackView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -33),
            changePageButtonStackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 40),
            changePageButtonStackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -40)
        ])
    }
}

// MARK: 텍스트필드 델리게이트
extension SignUpEnterNickNameEmailView: UITextFieldDelegate {
    
    @objc private func textFieldEditingChanged(_ textField: UITextField) {
        if textField.text?.count == 1 {
            if textField.text?.first == " " {
                textField.text = ""
                return
            }
        }
        guard
            let nickName = nickNameTextField.text, !nickName.isEmpty,
            let email = emailTextField.text, !email.isEmpty
        else {
            signUpLoverNextPageButton.isEnabled = false
            return
        }
        signUpLoverNextPageButton.isEnabled = true
    }
    
    // 키보드 엔터키가 눌렸을때 (다음 동작을 허락할 것인지)
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // 두개의 텍스트필드를 모두 종료 (키보드 내려가기)
        if emailTextField.text != "", nickNameTextField.text != "", nickNameTextField.text != "" {
            nickNameTextField.resignFirstResponder()
            return true
        } else if emailTextField.text != "", nickNameTextField.text != "" {
            nickNameTextField.becomeFirstResponder()
            return true
        } else if emailTextField.text != "" {
            nickNameTextField.becomeFirstResponder()
            return true
        }
            return false
        }
    
    // 텍스트필드 이외의 영역을 눌렀을때 키보드 내려가도록
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        emailTextField.resignFirstResponder()
        nickNameTextField.resignFirstResponder()
        nickNameTextField.resignFirstResponder()
    }
    
    // 이메일 텍스트필드 형식 제약조건
    func textFieldDidEndEditing(_ textField: UITextField) {
        let idPattern = #"^[a-zA-Z0-9+-\_.]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$"#
        let isVaildPattern = (emailTextField.text!.range(of: idPattern, options: .regularExpression) != nil)
        if emailTextField.text!.isEmpty {
            emailFormatDescriptionLabel.isHidden = true
        } else if isVaildPattern {
            emailFormatDescriptionLabel.isHidden = true
        } else {
            emailFormatDescriptionLabel.isHidden = false
        }
    }
    
    
    // 텍스트필드 별 글자수 제한
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField == nickNameTextField {
            nickNameDescriptionLabel.text = "한글/영문/숫자/특수문자 구성"
            nickNameDescriptionLabel.textColor = #colorLiteral(red: 0.46, green: 0.46, blue: 0.46, alpha: 1)
        }
        
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
        case emailTextField:
            maxLength = 100
            allowedCharacterSet = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!#$%&'*+-/=?^_`{|}~.(),:;<>@")
        case nickNameTextField:
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
}
