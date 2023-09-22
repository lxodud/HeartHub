//
//  TokenProvideable.swift
//  HeartHub
//
//  Created by 이태영 on 2023/09/20.
//

import Foundation

protocol TokenProvidable {
    func saveToken(with token: Token)
    func updateToken(with token: Token)
    func fetchAccessToken() -> String?
    func fetchRefreshToken() -> String?
    func deleteToken()
}
