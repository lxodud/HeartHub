//
//  RequestFailResponse.swift
//  HeartHub
//
//  Created by 이태영 on 2023/08/20.
//

import Foundation

struct RequestFailResponseDTO: Decodable {
    let isSuccess: Bool
    let code: Int
    let message: String
}
