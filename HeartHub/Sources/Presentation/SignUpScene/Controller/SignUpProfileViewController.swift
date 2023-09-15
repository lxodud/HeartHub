//
//  SignUpViewController.swift
//  HeartHub
//
//  Created by 제민우 on 2023/07/06.
//

import UIKit

final class SignUpProfileViewController: UIViewController {
    
    private let signUpProfileView = SignUpProfileView()
    private let userInformationManager: SignUpManager
    
    private var sexButtons: [UIButton] = []
    
    init(userInformationManager: SignUpManager) {
        self.userInformationManager = userInformationManager
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = signUpProfileView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureAddTarget()
        configureSexButton()
    }
}

// MARK: Configure AddTarget
extension SignUpProfileViewController {
    private func configureAddTarget() {
        signUpProfileView.signUpProfileNextPageButton.addTarget(self, action: #selector(didTapNextPageButton), for: .touchUpInside)
        signUpProfileView.signUpProfilePreviousPageButton.addTarget(self, action: #selector(didTappreviousPageButton), for: .touchUpInside)
        signUpProfileView.idCheckBtn.addTarget(self, action: #selector(didTapIdCheckBtn), for: .touchUpInside)
        signUpProfileView.maleBtn.addTarget(self, action: #selector(didTapMaleBtn), for: .touchUpInside)
        signUpProfileView.femaleBtn.addTarget(self, action: #selector(didTapMaleBtn), for: .touchUpInside)
        signUpProfileView.birthdayDatePicker.addTarget(self, action: #selector(didChangedBirthDayDate), for: .valueChanged)
    }
    
    private func configureSexButton() {
        sexButtons.append(signUpProfileView.maleBtn)
        sexButtons.append(signUpProfileView.femaleBtn)
        
        for (index, button) in sexButtons.enumerated() {
            button.addTarget(self, action: #selector(didTapSexButton), for: .touchUpInside)
            button.tag = index
        }
    }

    @objc private func didTapNextPageButton() {
        sexButtons.forEach {
            if $0.isSelected {
                if $0 == signUpProfileView.maleBtn {
                    userInformationManager.gender = "M"
                } else {
                    userInformationManager.gender = "W"
                }
            }
        }
        
        userInformationManager.password = signUpProfileView.pwTextField.text
        userInformationManager.birth = signUpProfileView.birthdayDateTextField.text
        
        let signUpLoverLinkingVC = SignUpEnterNickNameEmailViewController(
            userInformationManager: userInformationManager
        )
        navigationController?.pushViewController(signUpLoverLinkingVC, animated: true)
    }
    
    @objc private func didTappreviousPageButton() {
        navigationController?.popViewController(animated: true)
    }

    
    @objc private func didTapIdCheckBtn() {
        guard let id = signUpProfileView.idTextField.text else {
            return
        }
        
        userInformationManager.checkIDAvailability(with: id) { isNotDuplicate in
            DispatchQueue.main.async {
                if isNotDuplicate {
                    self.signUpProfileView.idDescriptionLabel.text = "사용 가능한 아이디입니다."
                    self.signUpProfileView.idDescriptionLabel.textColor = UIColor(
                        red: 0.105,
                        green: 0.751,
                        blue: 0.325,
                        alpha: 1
                    )

                } else {
                    self.signUpProfileView.idDescriptionLabel.text = "중복된 아이디입니다."
                    self.signUpProfileView.idDescriptionLabel.textColor = UIColor(
                        red: 1,
                        green: 0.004,
                        blue: 0.004,
                        alpha: 1
                    )
                }
            }
        }
    }
    
    @objc private func didTapSexButton(_ sender: UIButton) {
        self.sexButtons.forEach {
            if $0.tag == sender.tag {
                $0.isSelected = true
            } else {
                $0.isSelected = false
            }
        }
    }
    
    @objc private func didTapMaleBtn() {
        if signUpProfileView.maleBtn.isSelected == true {
            signUpProfileView.maleBtn.isSelected = false
         } else {
             signUpProfileView.maleBtn.isSelected = true
         }
    }
    
    @objc private func didTapFemaleBtn() {
        if signUpProfileView.femaleBtn.isSelected == true {
            signUpProfileView.femaleBtn.isSelected = false
         } else {
             signUpProfileView.femaleBtn.isSelected = true
         }
    }
    
    @objc private func didChangedBirthDayDate(_ sender: UIDatePicker) {
        signUpProfileView.birthdayDateTextField.text = dateFormat(date: sender.date)
    }
}

extension SignUpProfileViewController {
    private func dateFormat(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 MM월 dd일"
        
        return formatter.string(from: date)
    }
}
