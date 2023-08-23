//
//  PasswordChaggeView.swift
//  HeartHub
//
//  Created by 전제윤 on 2023/08/14.
//
import UIKit

final class PasswordChangeView: UIView {
    
    private var pwdChangeLabel: UILabel = {
        let label = UILabel()
        label.text = "비밀번호 변경하기"
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.textColor = .black
        return label
    }()
    
    lazy var beforepwdTextField: UITextField = {
        var tf = UITextField()
        tf.backgroundColor = .clear
        tf.textColor = #colorLiteral(red: 0.07, green: 0.07, blue: 0.07, alpha: 0.5)
        tf.autocapitalizationType = .none
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textViewHeight))
        tf.leftView = paddingView
        tf.leftViewMode = .always
        
        let eyeButton = UIButton(type: .custom)
        let image = UIImage(systemName: "eye.slash.fill")
        eyeButton.setImage(image, for: .normal)
        eyeButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: -10, bottom: 0, right: 0)
        eyeButton.frame = CGRect(x: 0, y: 0, width: 30, height: textViewHeight)
        eyeButton.addTarget(self, action: #selector(showPwd(sender:)), for: .touchUpInside)
        tf.rightViewMode = .always
        tf.rightView = eyeButton
        tf.attributedPlaceholder = NSAttributedString(
            string: "  기존 비밀번호를 입력해주세요.",
            attributes: [
                NSAttributedString.Key.foregroundColor: UIColor(red: 0.067, green: 0.067, blue: 0.067, alpha: 0.5),
                NSAttributedString.Key.font: UIFont(name: "Pretendard-Regular", size: 14)!
            ])
        tf.textAlignment = .left
        tf.layer.cornerRadius = 18
        tf.layer.borderWidth = 1.0
        tf.layer.borderColor = UIColor.darkGray.cgColor
        tf.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
        tf.isSecureTextEntry = true
        return tf
    }()
    
    
    private var beforeViewUnderLabel: UILabel = {
        let label = UILabel()
        label.text = "영문/숫자/특수문자 구성"
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        return label
    }()
    
    lazy var newpwdTextField: UITextField = {
        var tf = UITextField()
        tf.backgroundColor = .clear
        tf.textColor = #colorLiteral(red: 0.07, green: 0.07, blue: 0.07, alpha: 0.5)
        tf.autocapitalizationType = .none
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textViewHeight))
        tf.leftView = paddingView
        tf.leftViewMode = .always
        let eyeButton = UIButton(type: .custom)
        let image = UIImage(systemName: "eye.slash.fill")
        eyeButton.setImage(image, for: .normal)
        eyeButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: -10, bottom: 0, right: 0)
        eyeButton.frame = CGRect(x: 0, y: 0, width: 30, height: textViewHeight)
        eyeButton.addTarget(self, action: #selector(showPwd(sender:)), for: .touchUpInside)
        tf.rightViewMode = .always
        tf.rightView = eyeButton
        
        tf.attributedPlaceholder = NSAttributedString(
            string: "새 비밀번호를 입력해주세요.",
            attributes: [
                NSAttributedString.Key.foregroundColor: UIColor(red: 0.067, green: 0.067, blue: 0.067, alpha: 0.5),
                NSAttributedString.Key.font: UIFont(name: "Pretendard-Regular", size: 14)!
            ])
        tf.textAlignment = .left
        tf.layer.cornerRadius = 18
        tf.layer.borderWidth = 1.0
        tf.layer.borderColor = UIColor.darkGray.cgColor
        tf.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        tf.isSecureTextEntry = true
        return tf
    }()
    
    private var newViewUnderLabel: UILabel = {
        let label = UILabel()
        label.text = "영문/숫자/특수문자 구성"
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        return label
    }()
    
    lazy var beforeStackView: UIStackView = {
        let st = UIStackView(arrangedSubviews: [beforepwdTextField, beforeViewUnderLabel])
        st.axis = .vertical
        st.distribution = .fillEqually
        st.alignment = .fill
        return st
    }()
    
    lazy var newStackView: UIStackView = {
        let st = UIStackView(arrangedSubviews: [newpwdTextField, newViewUnderLabel])
        st.axis = .vertical
        st.distribution = .fillEqually
        st.alignment = .fill
        return st
    }()
    
    
    let passwordChangebtn: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.layer.cornerRadius = 15
        button.clipsToBounds = true
        button.layer.borderWidth = 1
        button.layer.borderColor = #colorLiteral(red: 0.9819073081, green: 0.4734940529, blue: 0.8320614696, alpha: 1)
        button.setTitle("비밀번호 변경하기", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.addTarget(self, action: #selector(changePassword(sender:)), for: .touchUpInside)
        return button
    }()
    
    private let textViewHeight: CGFloat = 40
    
    //MARK: - 뷰 초기화
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
        setConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addViews() {
        [pwdChangeLabel, beforeStackView, newStackView, passwordChangebtn].forEach{ addSubview($0)}
    }
    
    private func setConstraints() {
        pwdChangeLabelConstraints()
        beforeStackViewConstraints()
        newStackViewConstraints()
        passwordChangebtnConstraints()
        
    }
    
    
    
    private func pwdChangeLabelConstraints() {
        pwdChangeLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pwdChangeLabel.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            pwdChangeLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
        ])
    }
    
    
    private func beforeStackViewConstraints() {
        beforeStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            beforeStackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 30),
            beforeStackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -30),
            beforeStackView.topAnchor.constraint(equalTo: pwdChangeLabel.bottomAnchor, constant: 220),
            beforeStackView.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.11),
            
        ])
    }
    
    private func newStackViewConstraints() {
        newStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            newStackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 30),
            newStackView.topAnchor.constraint(equalTo: beforeStackView.bottomAnchor, constant: 5),
            newStackView.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.11),
            newStackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -30),
        ])
        
    }
    
    private func passwordChangebtnConstraints() {
        passwordChangebtn.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            passwordChangebtn.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 30),
            passwordChangebtn.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -30),
            passwordChangebtn.topAnchor.constraint(equalTo: beforeStackView.bottomAnchor, constant: 210),
            passwordChangebtn.heightAnchor.constraint(equalToConstant: 55)
        ])
    }
    
    @objc private func showPwd(sender: UIButton){
        if sender.imageView?.image == UIImage(systemName: "eye.slash.fill") {
            sender.setImage(UIImage(systemName: "eye.fill"), for: .normal)
            if sender == beforepwdTextField.rightView {
                beforepwdTextField.isSecureTextEntry = false
            } else {
                newpwdTextField.isSecureTextEntry = false
            }
        } else {
            sender.setImage(UIImage(systemName: "eye.slash.fill"), for: .normal)
            if sender == beforepwdTextField.rightView {
                beforepwdTextField.isSecureTextEntry = true
            } else {
                newpwdTextField.isSecureTextEntry = true
            }
        }
    }
    
    
    @objc private func changePassword(sender: UIButton) {
        guard let oldPassword = beforepwdTextField.text,
              let newPassword = newpwdTextField.text else {
            return
        }
        if oldPassword == newPassword {
            let alertController = UIAlertController(
                title: "비밀번호 변경 완료",
                message: "비밀번호 변경이 완료되었습니다.",
                preferredStyle: .alert
            )
            let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
            alertController.addAction(okAction)
            UIApplication.shared.keyWindow?.rootViewController?.present(alertController, animated: true, completion: nil)
        } else {
            let alertController = UIAlertController(
                title: "비밀번호 불일치",
                message: "기존 비밀번호와 새 비밀번호가 일치하지 않습니다.",
                preferredStyle: .alert
            )
            let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
            alertController.addAction(okAction)
            UIApplication.shared.keyWindow?.rootViewController?.present(alertController, animated: true, completion: nil)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        beforepwdTextField.resignFirstResponder()
        newpwdTextField.resignFirstResponder()
    }
}

