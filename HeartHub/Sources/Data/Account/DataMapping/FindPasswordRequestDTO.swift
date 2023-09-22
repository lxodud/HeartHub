//
//  FindPasswordRequestDTO.swift
//  HeartHub
//
//  Created by 이태영 on 2023/08/13.
//

import Foundation

struct FindPasswordRequestDTO: Encodable {
    let id: String
    let email: String
    
    enum CodingKeys: String, CodingKey {
        case id = "username"
        case email
    }
}
