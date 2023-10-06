//
//  AuthenticateEmailResponseDTO.swift
//  HeartHub
//
//  Created by 이태영 on 2023/10/04.
//

struct SendVerificationCodeResponseDTO: Decodable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let verificationCode: String
    
    private enum CodingKeys: String, CodingKey {
        case isSuccess
        case code
        case message
        case verificationCode = "data"
    }
}
