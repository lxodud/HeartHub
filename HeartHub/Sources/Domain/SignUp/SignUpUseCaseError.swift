//
//  SignUpUseCaseError.swift
//  HeartHub
//
//  Created by 이태영 on 2023/10/19.
//

import Foundation

enum SignUpUseCaseError: Error {
    case startDateMissing
    case idMissing
    case passwordMissing
    case genderMissing
    case birthMissing
    case nicknameMissing
    case emailMissing
}

extension SignUpUseCaseError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .startDateMissing:
            return NSLocalizedString("시작날짜 누락", comment: "시작날짜 누락")
        case .idMissing:
            return NSLocalizedString("아이디 누락", comment: "아이디 누락")
        case .passwordMissing:
            return NSLocalizedString("비밀번호 누락", comment: "비밀번호 누락")
        case .genderMissing:
            return NSLocalizedString("성별 누락", comment: "성별 누락")
        case .birthMissing:
            return NSLocalizedString("생년월일 누락", comment: "생년월일 누락")
        case .nicknameMissing:
            return NSLocalizedString("닉네임 누락", comment: "닉네임 누락")
        case .emailMissing:
            return NSLocalizedString("이메일 누락", comment: "이메일 누락")
        }
    }
}
