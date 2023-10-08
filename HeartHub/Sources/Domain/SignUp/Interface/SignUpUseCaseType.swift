//
//  SignUpUseCase.swift
//  HeartHub
//
//  Created by 이태영 on 2023/09/24.
//

import Foundation

protocol SignUpUseCaseType {
    func upsertStartDate(_ date: Date)
    func upsertId(_ id: String)
    func upsertPassword(_ password: String)
    func upsertGender(_ gender: Gender)
    func upsertBirth(_ date: Date)
    func upsertNickname(_ nickname: String)
    func upsertEmail(_ email: String)
}
