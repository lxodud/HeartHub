//
//  LognRequestDTO.swift
//  HeartHub
//
//  Created by 이태영 on 2023/08/13.
//

import Foundation

struct LoginRequestDTO: Encodable {
    let id: String
    let password: String
    
    enum CodingKeys: String, CodingKey {
        case id = "username"
        case password
    }
}
