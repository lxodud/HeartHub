//
//  FetchGoodCountResponse.swift
//  HeartHub
//
//  Created by 이태영 on 2023/08/22.
//

import Foundation

struct FetchGoodCountResponseDTO: Decodable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let data: Int
}
