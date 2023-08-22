//
//  FetchButtonStatusResponseDTO.swift
//  HeartHub
//
//  Created by 이태영 on 2023/08/22.
//

import Foundation

struct FetchButtonStatusResponseDTO: Decodable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let data: Status
    
    struct Status: Decodable {
        let statusString: String
        
        private enum CodingKeys: String, CodingKey {
            case statusString = "status"
        }
        
        var status: Bool {
            switch statusString {
            case "F":
                return false
            default:
                return true
            }
        }
    }
}
