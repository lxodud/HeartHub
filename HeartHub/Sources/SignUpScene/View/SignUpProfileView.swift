//
//  SignUpView2.swift
//  HeartHub
//
//  Created by 제민우 on 2023/07/11.
//

import UIKit

final class SignUpProfileView: UIView {
    
    private let signUpBackgroundView = SignUpBackgroundView(
        heartImage: "HeartIcon1:3",
        ourStartLabelText: "사랑을 시작해볼까요?",
        descriptionLabelText: "계정을 생성하여 HeartHuB를 즐겨보아요.")
    
    // MARK: 아이디, 비밀번호 입력란
    // 아이디 입력 텍스트필드
    let idTextField = SignUpUserInfoTextField(
        placeholder: "아이디를 입력하세요",
        keyboardType: .default, isSecureTextEntry: false)
    
    // 아이디 중복확인 버튼
    lazy var idCheckBtn: UIButton = {
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
    
    // 아이디 제약
    var idDescriptionLabel: UILabel = {
        var label = UILabel()
        label.text = "영문/숫자 구성"
        label.font = UIFont(name: "Pretendard-Regular", size: 12)
        label.textAlignment = .left
        label.textColor = #colorLiteral(red: 0.46, green: 0.46, blue: 0.46, alpha: 1)
        return label
    }()
    
    // 비밀번호 입력 텍스트필드
    var pwTextField = SignUpUserInfoTextField(
        placeholder: "비밀번호를 입력하세요",
        keyboardType: .default,
        isSecureTextEntry: true)
    
    
    // 비밀번호 중복확인 버튼
    var pwCheckBtn: UIButton = {
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
    
    // 비밀번호 제약 레이블
    var pwDescriptionLabel: UILabel = {
        var label = UILabel()
        label.text = "영문/숫자/특수문자 구성"
        label.font = UIFont(name: "Pretendard-Regular", size: 12)
        label.textAlignment = .left
        label.textColor = #colorLiteral(red: 0.46, green: 0.46, blue: 0.46, alpha: 1)
        return label
    }()
    
    // 닉네임, 이메일, 비밀번호 입력 스택뷰
    private lazy var enterStackView: UIStackView = {
        let stView = UIStackView(arrangedSubviews: [idTextField, pwTextField])
        stView.spacing = 30
        stView.axis = .vertical
        stView.distribution = .fillEqually
        stView.alignment = .fill
        return stView
    }()
    
    // MARK: 성별 선택
    // 남자 버튼
    lazy var maleBtn: UIButton = {
        var btn = UIButton(type: .custom)
        btn.backgroundColor = .clear
        btn.layer.cornerRadius = 18
        btn.layer.borderWidth = 1
        btn.layer.borderColor = #colorLiteral(red: 0.8588235378, green: 0.8588235378, blue: 0.8588235378, alpha: 1)
        
        // 라디오버튼 구현
        btn.setImage(UIImage(named: "AgreeRadioBtnUnChecked"), for: .normal)
        btn.setImage(UIImage(named: "AgreeRadioBtnChecked"), for: .selected)
        btn.imageView?.contentMode = .scaleAspectFit
        btn.contentHorizontalAlignment = .leading
        btn.addSubview(maleLabel)
        return btn
    }()
    
    private let maleLabel: UILabel = {
        let label = UILabel()
        label.text = "남"
        label.font = UIFont(name: "Pretendard-Regular", size: 14)
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.textColor = #colorLiteral(red: 0.46, green: 0.46, blue: 0.46, alpha: 1)
        return label
    }()
    
    lazy var femaleBtn: UIButton = {
        var btn = UIButton(type: .custom)
        btn.backgroundColor = .clear
        btn.layer.cornerRadius = 18
        btn.layer.borderWidth = 1
        btn.layer.borderColor = #colorLiteral(red: 0.8588235378, green: 0.8588235378, blue: 0.8588235378, alpha: 1)
        
        // 라디오버튼 구현
        btn.setImage(UIImage(named:"AgreeRadioBtnUnChecked"), for: .normal)
        btn.setImage(UIImage(named: "AgreeRadioBtnChecked"), for: .selected)
        btn.imageView?.contentMode = .scaleAspectFit
        btn.contentHorizontalAlignment = .leading
        btn.addSubview(femaleLabel)
        return btn
    }()
    
    private let femaleLabel: UILabel = {
        let label = UILabel()
        label.text = "여"
        label.font = UIFont(name: "Pretendard-Regular", size: 14)
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.textColor = #colorLiteral(red: 0.46, green: 0.46, blue: 0.46, alpha: 1)
        return label
    }()
    
    // 남녀 버튼 스택뷰
    private lazy var sexBtnStackView: UIStackView = {
        let stView = UIStackView(arrangedSubviews: [maleBtn, femaleBtn])
        stView.spacing = 19
        stView.axis = .horizontal
        stView.distribution = .fillEqually
        stView.alignment = .fill
        return stView
    }()
    
    // MARK: 생년월일 텍스트필드
    let birthdayDatePicker = SignUpDatePicker()
    
    let birthdayDateTextField = SignUpDateTextField(placeholder: "생년월일")
    
    let signUpProfilePreviousPageButton = SignUpChangePageButton(buttonImage: "LeftArrow")
    let signUpProfileNextPageButton = SignUpChangePageButton(buttonImage: "RightArrow")
    
    private lazy var changePageButtonStackView: UIStackView = {
        let stView = UIStackView(arrangedSubviews: [signUpProfilePreviousPageButton, signUpProfileNextPageButton])
        stView.axis = .horizontal
        stView.spacing = 198
        stView.distribution = .fillEqually
        stView.alignment = .fill
        return stView
    }()
    
    // MARK: 뷰 초기화
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureInitialSetting()
        configureSubViews()
        configureLayout()
        configureAddTarget()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Configure InitialSetting
extension SignUpProfileView {
    private func configureInitialSetting() {
        backgroundColor = .white
        
        birthdayDateTextField.inputView = birthdayDatePicker
        
        idTextField.delegate = self
        pwTextField.delegate = self
        birthdayDateTextField.delegate = self
        signUpProfileNextPageButton.isEnabled = false
    }
    
    private func configureAddTarget() {
        [idTextField, pwTextField, birthdayDateTextField].forEach {
            $0.addTarget(self, action: #selector(textFieldEditingChanged(_:)), for: .allEditingEvents)
        }
    }
}

// MARK: Configure Layout
extension SignUpProfileView {
    private func configureSubViews() {
        idTextField.addSubview(idCheckBtn)
        pwTextField.addSubview(pwCheckBtn)
        
        [signUpBackgroundView,
         enterStackView,
         idDescriptionLabel,
         pwDescriptionLabel,
         sexBtnStackView,
         birthdayDateTextField,
         changePageButtonStackView].forEach {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        [idTextField,
         pwTextField,
         idCheckBtn,
         maleLabel,
         femaleLabel,
         signUpProfilePreviousPageButton,
         signUpProfileNextPageButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
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
            
            idTextField.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.04),
            
            pwTextField.heightAnchor.constraint(equalTo: idTextField.heightAnchor),
            
            // MARK: idCheckBtn Constraints
            idCheckBtn.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.19),
            idCheckBtn.topAnchor.constraint(equalTo: idTextField.topAnchor),
            idCheckBtn.bottomAnchor.constraint(equalTo: idTextField.bottomAnchor),
            idCheckBtn.trailingAnchor.constraint(equalTo: idTextField.trailingAnchor),
            
            // MARK: ID,PW idDescriptionLabel Constraints
            idDescriptionLabel.topAnchor.constraint(equalTo: idTextField.bottomAnchor, constant: 3),
            idDescriptionLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 44),
            idDescriptionLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: 211),
            
            pwDescriptionLabel.topAnchor.constraint(equalTo: pwTextField.bottomAnchor, constant: 3),
            pwDescriptionLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 44),
            
            // MARK: sexBtnStackView Constraints
            sexBtnStackView.heightAnchor.constraint(equalTo: idTextField.heightAnchor),
            sexBtnStackView.topAnchor.constraint(equalTo: pwDescriptionLabel.bottomAnchor, constant: 15),
            sexBtnStackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 32),
            sexBtnStackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -203),
            
            maleLabel.centerYAnchor.constraint(equalTo: maleBtn.centerYAnchor),
            maleLabel.leadingAnchor.constraint(equalTo: maleBtn.leadingAnchor, constant: 41),
            maleLabel.trailingAnchor.constraint(equalTo: maleBtn.trailingAnchor, constant: -14),
            
            femaleLabel.centerYAnchor.constraint(equalTo: femaleBtn.centerYAnchor),
            femaleLabel.leadingAnchor.constraint(equalTo: femaleBtn.leadingAnchor, constant: 41),
            femaleLabel.trailingAnchor.constraint(equalTo: femaleBtn.trailingAnchor, constant: -14),
            
            // MARK: birthdayStackView Constraints
            birthdayDateTextField.centerXAnchor.constraint(equalTo: centerXAnchor),
            birthdayDateTextField.heightAnchor.constraint(equalTo: idTextField.heightAnchor),
            birthdayDateTextField.topAnchor.constraint(equalTo: maleBtn.bottomAnchor, constant: 22),
            birthdayDateTextField.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 32),
            
            // MARK: changePageButton Constraints
            signUpProfilePreviousPageButton.heightAnchor.constraint(equalTo: signUpProfilePreviousPageButton.widthAnchor),
            signUpProfileNextPageButton.heightAnchor.constraint(equalTo: signUpProfileNextPageButton.widthAnchor),
            
            changePageButtonStackView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -33),
            changePageButtonStackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 40),
            changePageButtonStackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -40)
        ])
    }
}

// MARK: 텍스트필드 델리게이트
extension SignUpProfileView: UITextFieldDelegate {
    
    // MARK: textFieldEditingChanged
    @objc private func textFieldEditingChanged(_ textField: UITextField) {
        if textField.text?.count == 1 {
            if textField.text?.first == " " {
                textField.text = ""
                return
            }
        }
        guard
            let id = idTextField.text, !id.isEmpty,
            let pw = pwTextField.text, !pw.isEmpty,
            let date = birthdayDateTextField.text, !date.isEmpty,
            (maleBtn.isSelected || femaleBtn.isSelected)
        else {
            signUpProfileNextPageButton.isEnabled = false
            return
        }
        signUpProfileNextPageButton.isEnabled = true
    }
    
    // MARK: textFieldShouldReturn
    // 키보드 엔터키가 눌렸을때 (다음 동작을 허락할 것인지)
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // 두개의 텍스트필드를 모두 종료 (키보드 내려가기)
        if pwTextField.text != "", idTextField.text != "" {
            pwTextField.resignFirstResponder()
            return true
            // 두번째 텍스트필드로 넘어가도록
        } else if idTextField.text != "" {
            pwTextField.becomeFirstResponder()
            return true
        }
        
        if birthdayDateTextField.text != "" {
            birthdayDateTextField.resignFirstResponder()
            return true
        }
        
        return false
    }
    
    // 텍스트필드 이외의 영역을 눌렀을때 키보드 내려가도록
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        idTextField.resignFirstResponder()
        pwTextField.resignFirstResponder()
        birthdayDateTextField.resignFirstResponder()
    }
    
    // MARK: textFieldShouldChangeCharactersIn
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        if textField == idTextField {
            idDescriptionLabel.text = "영문/숫자 구성"
            idDescriptionLabel.textColor = #colorLiteral(red: 0.46, green: 0.46, blue: 0.46, alpha: 1)
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
        
        let updatedText = (text as NSString).replacingCharacters(in: range, with: string)
        
        let maxLength: Int
        var allowedCharacterSet: CharacterSet
        
        switch textField {
        case idTextField:
            maxLength = 18
            allowedCharacterSet = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789")
            return updatedText.count <= maxLength && allowedCharacterSet.isSuperset(of: CharacterSet(charactersIn: string))
            
        case pwTextField:
            maxLength = 15
            allowedCharacterSet = CharacterSet(charactersIn:
                                                "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#$%^&*()-_?+=~"
            )
            return updatedText.count <= maxLength && allowedCharacterSet.isSuperset(of: CharacterSet(charactersIn: string))
            
        case birthdayDateTextField:
            maxLength = 4
            allowedCharacterSet = CharacterSet(charactersIn: "0123456789")
            if let year = Int(updatedText) {
                let currentYear = Calendar.current.component(.year, from: Date())
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
