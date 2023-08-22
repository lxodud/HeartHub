//
//  NewToken.swift
//  HeartHub
//
//  Created by 이태영 on 2023/08/21.
//

import Foundation

struct NewToken: Decodable {
    let newAccessToken: String
    let newRefreshToken: String
}
