//
//  SignUpInformation.swift
//  HeartHub
//
//  Created by 이태영 on 2023/09/24.
//

import Foundation

enum Gender {
    case male
    case female
}

struct SignUpInfomation {
    var startDate: Date?
    var birth: Date?
    var id: String?
    var password: String?
    var gender: Gender?
    var nickname: String?
    var email: String?
    var isAgreeMarketing: Bool?
}
