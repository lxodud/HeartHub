//
//  StartDateInputViewController.swift
//  HeartHub
//
//  Created by 이태영 on 2023/09/23.
//

import UIKit

final class StartDateInputViewController: UIViewController {
    private let titleLabel = SignUpTitleLabelStackView(
        title: "우리의 시작",
        description: "당신이 애인과 처음 사귀기 시작한 날은 언제인가요?"
    )
    
    private let dateTextField: UITextField = SignUpDateTextField(placeholder: "우리의 시작")
    private let selectDoneButton = UIBarButtonItem(systemItem: .done)
    
    private let startDatePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.locale = Locale(identifier: "ko-KR")
        return datePicker
    }()
    
    private let nextButton: UIButton = SignUpBottomButton(title: "다음")
    
    override func viewDidLoad() {
        configureSubview()
        configureLayout()
        configureNavigationBar()
    }
}

// MARK: Configure UI
extension StartDateInputViewController {
    private func configureSubview() {
        [titleLabel, dateTextField, nextButton].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        let toolBar = UIToolbar()
        let flexibleSpace = UIBarButtonItem(systemItem: .flexibleSpace)
        toolBar.items = [flexibleSpace, selectDoneButton]
        toolBar.sizeToFit()
        
        dateTextField.inputAccessoryView = toolBar
        dateTextField.inputView = startDatePicker
    }
    
    private func configureLayout() {
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            // MARK: titleLabel Constraints
            titleLabel.centerYAnchor.constraint(
                equalTo: safeArea.centerYAnchor,
                constant: -(view.bounds.height * 0.35)
            ),
            titleLabel.centerXAnchor.constraint(
                equalTo: safeArea.centerXAnchor
            ),
            titleLabel.widthAnchor.constraint(
                equalTo: safeArea.widthAnchor,
                multiplier: 0.8
            ),
            
            // MARK: dateTextField Constraints
            dateTextField.topAnchor.constraint(
                equalTo: titleLabel.bottomAnchor,
                constant: 30
            ),
            dateTextField.centerXAnchor.constraint(
                equalTo: safeArea.centerXAnchor
            ),
            dateTextField.widthAnchor.constraint(
                equalTo: safeArea.widthAnchor,
                multiplier: 0.8
            ),
            dateTextField.heightAnchor.constraint(
                equalToConstant: 35
            ),
            
            // MARK: nextButton Constraints
            nextButton.bottomAnchor.constraint(
                equalTo: safeArea.bottomAnchor,
                constant: -30
            ),
            nextButton.centerXAnchor.constraint(
                equalTo: safeArea.centerXAnchor
            ),
            nextButton.widthAnchor.constraint(
                equalTo: safeArea.widthAnchor,
                multiplier: 0.85
            )
        ])
    }
    
    private func configureNavigationBar() {
        let titleImage = UIImage(named: "HeartIcon0:3")
        let titleImageView = UIImageView()
        titleImageView.contentMode = .scaleAspectFit
        titleImageView.image = titleImage
        navigationItem.titleView = titleImageView
    }
}
