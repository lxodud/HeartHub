//
//  LoginCoordinatable.swift
//  HeartHub
//
//  Created by 이태영 on 2023/09/17.
//

protocol LoginCoordinatable: Coordinatable {
    func toLogin()
    func toFindPassword()
    func toFindId()
    func toSignUp()
    func showAlert(message: String)
    func toMain()
}
