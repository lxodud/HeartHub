//
//  SignUpCoordinatable.swift
//  HeartHub
//
//  Created by 이태영 on 2023/09/23.
//

import Foundation

protocol SignUpCoordinatable: Coordinatable {
    func toAccountProfileInput()
    func toNicknameEmailInput()
    func toTermAgree()
    func toPersonalInformationCollectionAndUsageDetail()
    func showAlert(message: String)
}
