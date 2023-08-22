//
//  EmailVerificationResponseDTO.swift
//  HeartHub
//
//  Created by 이태영 on 2023/08/18.
//

import Foundation

struct EmailVerificationResponseDTO: Decodable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let data: String
}
