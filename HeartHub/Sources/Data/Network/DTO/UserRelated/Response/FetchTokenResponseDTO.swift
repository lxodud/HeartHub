//
//  FetchTokenResponseDTO.swift
//  HeartHub
//
//  Created by 이태영 on 2023/08/19.
//

import Foundation

struct FetchTokenResponseDTO: Decodable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let data: Token
    
    struct Token: Decodable {
        let accessToken: String
        let refreshToken: String
    }
}
