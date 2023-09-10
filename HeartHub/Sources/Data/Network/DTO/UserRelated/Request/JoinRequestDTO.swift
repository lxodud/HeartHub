//
//  JoinRequestDTO.swift
//  HeartHub
//
//  Created by 이태영 on 2023/08/13.
//

import Foundation

struct JoinRequestDTO: Encodable {
    let username: String
    let password: String
    let gender: String
    let email: String
    let nickname: String
    let marketingStatus: String
    let mate: String
    let datingDate: String
    let birth: String
}
