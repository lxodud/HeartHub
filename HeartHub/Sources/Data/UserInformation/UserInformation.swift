//
//  UserInformation.swift
//  HeartHub
//
//  Created by 이태영 on 2023/08/21.
//

import Foundation

struct UserInformation: Decodable {
    let username: String
    let nickname: String
    let userImageUrl: String?
}
