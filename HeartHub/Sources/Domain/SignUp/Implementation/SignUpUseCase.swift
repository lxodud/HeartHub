//
//  SignUpUseCase.swift
//  HeartHub
//
//  Created by 이태영 on 2023/09/24.
//

import Foundation

final class SignUpUseCase {
    private var startDate: Date?
}

// MARK: Public Interface
extension SignUpUseCase: SignUpUseCaseType {
    func upsertStartDate(_ date: Date) {
        self.startDate = date
    }
}
