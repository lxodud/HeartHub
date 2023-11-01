//
//  MyPageCoordinatable.swift
//  HeartHub
//
//  Created by 이태영 on 2023/11/01.
//

import Foundation

protocol MyPageCoordinatable: Coordinatable {
    func toEditProfile()
    func toWithdrawal()
    func toChangePassword()
    func toLogin()
    func showAlert(message: String, action: (() -> Void)?)
}
