//
//  SignUpDatePicker.swift
//  HeartHub
//
//  Created by 제민우 on 2023/08/14.
//

import UIKit

final class SignUpDatePicker: UIDatePicker {

    override init(frame: CGRect) {
        super.init(frame: .zero)
        configureDatePicker()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Configure InitialSetting
extension SignUpDatePicker {
    private func configureDatePicker() {
        datePickerMode = .date
        preferredDatePickerStyle = .wheels
        locale = Locale(identifier: "ko-KR")
    }
}
