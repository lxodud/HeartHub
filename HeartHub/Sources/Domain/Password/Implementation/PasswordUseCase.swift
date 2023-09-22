//
//  PasswordUseCase.swift
//  HeartHub
//
//  Created by 이태영 on 2023/09/22.
//

import Foundation
import RxSwift

final class PasswordUseCase {
    private let passwordRepository: PasswordRepositoryType
    
    init(passwordRepository: PasswordRepositoryType = PasswordRepository()) {
        self.passwordRepository = passwordRepository
    }
}

// MARK: - Public Interface
extension PasswordUseCase: PasswordUseCaseType {
    func modifyPassword(current: String, new: String ) -> Completable {
        return passwordRepository.modifyPassword(current: current, new: new)
    }
}
