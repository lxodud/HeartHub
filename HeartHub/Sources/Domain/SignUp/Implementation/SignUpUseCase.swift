//
//  SignUpUseCase.swift
//  HeartHub
//
//  Created by 이태영 on 2023/09/24.
//

import Foundation

final class SignUpUseCase {
    private var startDate: Date?
    private var id: String?
    private var password: String?
    private var gender: Gender?
    private var birth: Date?
    private var nickname: String?
    private var email: String?
}

// MARK: Public Interface
extension SignUpUseCase: SignUpUseCaseType {
    func upsertStartDate(_ date: Date) {
        self.startDate = date
    }
    
    func upsertId(_ id: String) {
        self.id = id
    }
    
    func upsertPassword(_ password: String) {
        self.password = password
    }
    
    func upsertGender(_ gender: Gender) {
        self.gender = gender
    }
    
    func upsertBirth(_ birth: Date) {
        self.birth = birth
    }
    
    func upsertNickname(_ nickname: String) {
        self.nickname = nickname
    }
    
    func upsertEmail(_ email: String) {
        self.email = email
    }
}
