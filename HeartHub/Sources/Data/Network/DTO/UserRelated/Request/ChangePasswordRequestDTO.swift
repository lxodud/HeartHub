//
//  ChangePasswordRequestDTO.swift
//  HeartHub
//
//  Created by 이태영 on 2023/09/13.
//

import Foundation

struct ChangePasswordRequestDTO: Encodable {
    let token: String
    let currentPassword: String
    let changePassword: String
}
