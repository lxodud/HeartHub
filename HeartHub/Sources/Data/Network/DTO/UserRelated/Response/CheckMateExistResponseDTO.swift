//
//  CheckMateExistResponseDTO.swift
//  HeartHub
//
//  Created by 이태영 on 2023/09/09.
//

import Foundation

struct CheckMateExistResponseDTO {
    let isSuccess: Bool
    let code: Int
    let message: String
    let hasMate: Bool
    
    private enum CodingKeys: CodingKey {
        case isSuccess
        case code
        case message
        case data
    }
    
    private enum DataKeys: CodingKey {
        case hasMate
    }
}

extension CheckMateExistResponseDTO: Decodable {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        isSuccess = try container.decode(Bool.self, forKey: .isSuccess)
        code = try container.decode(Int.self, forKey: .code)
        message = try container.decode(String.self, forKey: .message)
        
        let dataContainer = try container.nestedContainer(keyedBy: DataKeys.self, forKey: .data)
        hasMate = try dataContainer.decode(Bool.self, forKey: .hasMate)
    }
}
