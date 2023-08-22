//
//  SetMateRequestDTO.swift
//  HeartHub
//
//  Created by 이태영 on 2023/08/13.
//

import Foundation

struct SetMateRequestDTO: Encodable {
    let currentUsername: String
    let matename: String
    
    private enum CodingKeys: String, CodingKey {
        case currentUsername
        case matename = "mateName"
    }
}
