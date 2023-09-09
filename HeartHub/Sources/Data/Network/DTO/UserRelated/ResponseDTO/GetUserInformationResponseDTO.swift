//
//  GetUserInfoResponseDTO.swift
//  HeartHub
//
//  Created by 이태영 on 2023/08/21.
//

import Foundation

struct GetUserInformationResponseDTO: Decodable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let data: UserInformation
}
