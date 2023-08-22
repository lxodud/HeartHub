//
//  GetMyInformationResponseDTO.swift
//  HeartHub
//
//  Created by 이태영 on 2023/08/21.
//

import Foundation

struct GetMyInformationResponseDTO: Decodable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let data: MyInformation
    
    struct MyInformation: Decodable {
        let myImageUrl: String
        let myNickname: String
        
        enum CodingKeys: String, CodingKey {
            case myImageUrl = "myImgUrl"
            case myNickname = "userNickName"
        }
    }
}
