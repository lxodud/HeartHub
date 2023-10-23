//
//  SignUpUseCase.swift
//  HeartHub
//
//  Created by 이태영 on 2023/09/24.
//

import Foundation
import RxSwift

enum Gender {
    case male
    case female
}

struct SignUpInformation {
    let startDate: Date
    let id: String
    let password: String
    let gender: Gender
    let birth: Date
    let nickname: String
    let email: String
    let isMarketingConsent: Bool
}

final class SignUpUseCase {
    var startDate: Date?
    var id: String?
    var password: String?
    var gender: Gender?
    var birth: Date?
    var nickname: String?
    var email: String?
    var isMarketingConsent: Bool = false
    
    var signUpInformation: SignUpInformation? {
        guard let startDate = startDate else {
            return nil
        }
        
        guard let id = id else {
            return nil
        }
        
        guard let password = password else {
            return nil
        }
        
        guard let gender = gender else {
            return nil
        }
        
        guard let birth = birth else {
            return nil
        }
        
        guard let nickname = nickname else {
            return nil
        }
        
        guard let email = email else {
            return nil
        }
        
        return SignUpInformation(
            startDate: startDate,
            id: id, password: password,
            gender: gender,
            birth: birth,
            nickname: nickname,
            email: email,
            isMarketingConsent: isMarketingConsent
        )
    }
}
