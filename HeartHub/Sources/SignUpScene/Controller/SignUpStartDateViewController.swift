
//
//  SignUpViewController.swift
//  HeartHub
//
//  Created by 제민우 on 2023/07/06.
//

import UIKit

final class SignUpStartDateViewController: UIViewController {
    
    private let signUpStartDateView = SignUpStartDateView()
    private let userInformationManager = SignUpManager()
    
    override func loadView() {
        view = signUpStartDateView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureAddTarget()
    }
}

// MARK: Configure AddTarget
extension SignUpStartDateViewController {
    private func configureAddTarget() {
        signUpStartDateView.signUpStartDateNextPageButton.addTarget(self, action: #selector(didTapNextPageButton), for: .touchUpInside)
        signUpStartDateView.signUpStartDatePreviousPageButton.addTarget(self, action: #selector(didTapPreviousPageButton), for: .touchUpInside)
        signUpStartDateView.startDatePicker.addTarget(self, action: #selector(didChangedStartDate), for: .valueChanged)
    }
    
    @objc private func didTapNextPageButton() {
        let datingDate = signUpStartDateView.startDateTextField.text
        userInformationManager.datingDate = datingDate
        let signUpProfileViewController = SignUpProfileViewController(userInformationManager: userInformationManager)
        
        self.navigationController?.pushViewController(signUpProfileViewController, animated: true)
    }
    
    @objc private func didTapPreviousPageButton() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func didChangedStartDate(_ sender: UIDatePicker) {
        signUpStartDateView.startDateTextField.text = dateFormat(date: sender.date)
    }
}

extension SignUpStartDateViewController {
    private func dateFormat(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 MM월 dd일"
        
        return formatter.string(from: date)
    }
}
