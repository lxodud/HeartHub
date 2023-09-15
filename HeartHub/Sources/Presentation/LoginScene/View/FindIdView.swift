//
//  FindIdView.swift
//  HeartHub
//
//  Created by 제민우 on 2023/07/16.
//

import UIKit

final class FindIdView: UIView {
    
    private let loginBackGroundView = LoginBackGroundView()
    
    private let keyboardBackgroundView: UIImageView = {
        var imgView = UIImageView()
        imgView.contentMode = .scaleAspectFit
        imgView.image = UIImage(named: "KeyboardBackground")
        return imgView
    }()
    
    let enterEmailTextField = LoginTextField(
        placeholder: "이메일을 입력하세요",
        keyboardType: .emailAddress,
        isSecureTextEntry: false
    )
    
    var findIdButton: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = .white
        button.layer.cornerRadius = 8
        button.layer.borderWidth = 1
        button.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        button.setTitle("아이디 찾기", for: .normal)
        button.titleLabel?.font = UIFont.init(name: "Pretendard-SemiBold", size: 16)
        button.setTitleColor(UIColor(red: 0.98, green: 0.18, blue: 0.74, alpha: 1), for: .normal)
        button.contentVerticalAlignment = .center
        return button
    }()
    
    // 이메일입력 + 아이디 찾기 버튼 스택뷰
    private lazy var emailTfFindIdBtnStackView: UIStackView = {
        let stview = UIStackView(arrangedSubviews: [enterEmailTextField, findIdButton])
        stview.spacing = 47
        stview.axis = .vertical
        stview.distribution = .fillEqually
        stview.alignment = .fill
        return stview
    }()
    
    // MARK: 아이디 찾기 + 회원가입 + 비밀번호찾기 버튼
    // 아이디 찾기 버튼
    var loginBtn: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = .clear
        button.setTitle("로그인", for: .normal)
        button.titleLabel?.textAlignment = .center
        button.setTitleColor(UIColor(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        button.titleLabel?.font = UIFont.init(name: "Pretendard-Regular", size: 16)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.titleLabel?.numberOfLines = 1
        return button
    }()
    
    // 회원가입 버튼
    var signUpBtn: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = .clear
        button.setTitle("회원가입", for: .normal)
        button.titleLabel?.textAlignment = .center
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.init(name: "Pretendard-Regular", size: 16)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.titleLabel?.numberOfLines = 1
        return button
    }()
    
    // 비밀번호 찾기 버튼
    var findPwBtn: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = .clear
        button.setTitle("비밀번호 찾기", for: .normal)
        button.titleLabel?.textAlignment = .center
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.init(name: "Pretendard-Regular", size: 16)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.titleLabel?.numberOfLines = 1
        return button
    }()
    
    // 회원가입 닉네임 로그인 사이 선
    private var lineView1: UIView = {
        let line = UIView()
        line.backgroundColor = #colorLiteral(red: 1, green: 0.9999999404, blue: 1, alpha: 1)
        return line
    }()
    
    private  var lineView2: UIView = {
        let line = UIView()
        line.backgroundColor = #colorLiteral(red: 1, green: 0.9999999404, blue: 1, alpha: 1)
        return line
    }()
    
    // 아이디찾기 + 선 + 회원가입 + 선 + 비밀번호 찾기 버튼 스택뷰
    private lazy var selectPageButtonStackView: UIStackView = {
        let stView = UIStackView(arrangedSubviews: [loginBtn, lineView1, signUpBtn, lineView2, findPwBtn])
        stView.spacing = 10
        stView.axis = .horizontal
        stView.distribution = .equalSpacing
        stView.alignment = .center
        return stView
    }()
    
    private var emailTfFindIdBtnStackViewTopConstraint: NSLayoutConstraint!
    
    private var keyboardBackgroundViewTopConstraint: NSLayoutConstraint!
    
    // MARK: 뷰 초기화
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureInitialSetting()
        configureNotification()
        configureSubviews()
        configureAddTarget()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateConstraints() {
        configureLayout()
        super.updateConstraints()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}

// MARK: Configure AddTarget
extension FindIdView {
    private func configureAddTarget() {
        enterEmailTextField.addTarget(self, action: #selector(textFieldEditingChanged(_:)), for: .editingChanged)
    }
}

// MARK: Configure Layout
extension FindIdView {
    
    private func configureInitialSetting() {
        enterEmailTextField.delegate = self
        findIdButton.isEnabled = false
    }
    
    private func configureSubviews() {
        [loginBackGroundView,
         selectPageButtonStackView,
         keyboardBackgroundView,
         emailTfFindIdBtnStackView].forEach {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    private func configureLayout() {
        let safeArea = safeAreaLayoutGuide
        
        emailTfFindIdBtnStackViewTopConstraint =
        emailTfFindIdBtnStackView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 556)
        
        keyboardBackgroundViewTopConstraint = keyboardBackgroundView.topAnchor.constraint(equalTo: topAnchor, constant: frame.height)
        
        NSLayoutConstraint.activate([
            
            // MARK: loginBackGrondView Constraints
            loginBackGroundView.centerXAnchor.constraint(equalTo: centerXAnchor),
            loginBackGroundView.centerYAnchor.constraint(equalTo: centerYAnchor),
            loginBackGroundView.topAnchor.constraint(equalTo: topAnchor),
            loginBackGroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            
            // MARK: keyboardBackgroundView Constraints
            keyboardBackgroundView.centerXAnchor.constraint(equalTo: centerXAnchor),
            keyboardBackgroundView.centerYAnchor.constraint(equalTo: centerYAnchor),
            keyboardBackgroundViewTopConstraint,
            keyboardBackgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            
            // MARK: emailTfFindIdBtnStackView Constraints
            emailTfFindIdBtnStackView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.169),
            emailTfFindIdBtnStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            emailTfFindIdBtnStackViewTopConstraint,
            emailTfFindIdBtnStackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 59),
       
            // MARK: signUpFindIdPwStackView Constraints
            selectPageButtonStackView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.028),
            selectPageButtonStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            selectPageButtonStackView.topAnchor.constraint(equalTo: emailTfFindIdBtnStackView.bottomAnchor, constant: 28),
            selectPageButtonStackView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -12),
            selectPageButtonStackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 68),
       
            // MARK: lineView1 Constraints
            lineView1.widthAnchor.constraint(equalToConstant: 1),
            lineView1.heightAnchor.constraint(equalTo: signUpBtn.heightAnchor, multiplier: 0.5),
          
            // MARK: lineView2 Constraints
            lineView2.widthAnchor.constraint(equalToConstant: 1),
            lineView2.heightAnchor.constraint(equalTo: lineView1.heightAnchor)
        ])
    }
}

// MARK: 키보드 올라오고 내려갈 때 레이아웃 변경
extension FindIdView {
    private func configureNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(moveUpAction), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(moveDownAction), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func moveUpAction() {
        emailTfFindIdBtnStackViewTopConstraint.constant = 318
        keyboardBackgroundViewTopConstraint.constant = 0
        UIView.animate(withDuration: 0.2) {
            self.layoutIfNeeded()
        }
    }
    
    @objc private func moveDownAction() {
        guard let emailTfFindIdBtnStackViewTopConstraint = emailTfFindIdBtnStackViewTopConstraint else {
            return
        }
        emailTfFindIdBtnStackViewTopConstraint.constant = 556
        
        keyboardBackgroundViewTopConstraint.constant = frame.height
        UIView.animate(withDuration: 0.2) {
            self.layoutIfNeeded()
        }
    }
}

// MARK: TextField Delegate Implement
extension FindIdView: UITextFieldDelegate {
    
    // id, pw 텍스트필드 입력값 없을 시 아이디찾기 버튼 비활성화
    @objc private func textFieldEditingChanged(_ textField: UITextField) {
        if textField.text?.count == 1 {
            if textField.text?.first == " " {
                textField.text = ""
                return
            }
        }
        guard
            let email = enterEmailTextField.text, !email.isEmpty
        else {
            findIdButton.isEnabled = false
            return
        }
        findIdButton.isEnabled = true
    }
    
    // 키보드 엔터키가 눌렸을때 (다음 동작을 허락할 것인지)
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if enterEmailTextField.text != "" {
            enterEmailTextField.resignFirstResponder()
        }
            return true
        }
    
    // 텍스트필드 이외의 영역을 눌렀을때 키보드 내려가도록
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        enterEmailTextField.resignFirstResponder()
    }
    
            
    // 텍스트필드 별 글자수 제한
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
        
        if textField == enterEmailTextField {
            maxLength = 100
            allowedCharacterSet = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!#$%&'*+-/=?^_`{|}~.(),:;<>@")
        } else {
            return false
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
