//
//  PasswordModifyViewModel.swift
//  HeartHub
//
//  Created by 이태영 on 2023/09/13.
//

import Foundation

final class PasswordModifyViewModel {
    private let myImformationService: MyInformationService
    
    private var canModify: (isNewPasswordInput: Bool, isCurrentPasswordInput: Bool) = (false, false) {
        didSet {
            conModifyHandler?(canModify.isNewPasswordInput && canModify.isCurrentPasswordInput)
        }
    }
    
    private var isSecureCurrentPassword: Bool = false {
        didSet {
            isSecureCurrentPasswordHandler?(isSecureCurrentPassword)
        }
    }
    
    private var isSecureNewPassword: Bool = false {
        didSet {
            isSecureNewPasswordHandler?(isSecureNewPassword)
        }
    }
    
    var conModifyHandler: ((Bool) -> Void)?
    var isSecureCurrentPasswordHandler: ((Bool) -> Void)?
    var isSecureNewPasswordHandler: ((Bool) -> Void)?
    
    init(myInformationService: MyInformationService = MyInformationService()) {
        self.myImformationService = myInformationService
    }
}

// MARK: - Public Interface
extension PasswordModifyViewModel {
    func modifyPassword(current: String?, new: String?, completion: @escaping (String) -> Void) {
        guard let currentPassword = current,
              let newPassword = new
        else {
            return
        }
        
        myImformationService.modifyPassword(current: currentPassword, new: newPassword) { isSuccess in
            if isSuccess {
                completion("변경 성공했습니다.")
            } else {
                completion("변경 실패했습니다.")
            }
        }
    }
    
    func inputCurrentPassword(_ password: String) {
        canModify.isNewPasswordInput = !password.isEmpty
    }
    
    func inputNewPassword(_ password: String) {
        canModify.isCurrentPasswordInput = !password.isEmpty
    }
    
    func tapCurrentPasswordSecure() {
        isSecureCurrentPassword.toggle()
    }
    
    func tapNewPasswordSecure() {
        isSecureNewPassword.toggle()
    }
}
