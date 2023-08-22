//
//  SignInRequestDTO.swift
//  HeartHub
//
//  Created by 이태영 on 2023/08/13.
//

import Foundation

struct SignInRequestDTO: Encodable {
    let username: String
    let password: String
}
