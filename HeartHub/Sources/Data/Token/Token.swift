//
//  Token.swift
//  HeartHub
//
//  Created by 이태영 on 2023/08/13.
//

import Foundation

struct Token: Decodable {
    let accessToken: String
    let refreshToken: String
}
