//
//  TokenRepository.swift
//  HeartHub
//
//  Created by 이태영 on 2023/08/13.
//

import Foundation

final class TokenRepository {
    private let keychainManager = KeychainManager()
    private let accessTokenAttributes: [String: Any] = [
        kSecClass as String: kSecClassGenericPassword,
        kSecAttrAccount as String: "HeartHub",
        kSecAttrService as String: "accessToken"
    ]
    private let refreshTokenAttributes: [String: Any] = [
        kSecClass as String: kSecClassGenericPassword,
        kSecAttrAccount as String: "HeartHub",
        kSecAttrService as String: "refreshToken"
    ]
    private let fetchQuery: [String: Any] = [
        kSecMatchLimit as String: kSecMatchLimitOne,
        kSecReturnData as String: true
    ]
    
    private func convertTokenTokSecValueData(token: String) -> [String: Any]? {
        guard let data = token.data(using: .utf8) else {
            return nil
        }
        
        return [kSecValueData as String: data]
    }
}

// MARK: Public Interface
extension TokenRepository {
    func saveToken(with token: Token) {
        guard let accessToken = convertTokenTokSecValueData(token: token.accessToken),
              let refreshToken = convertTokenTokSecValueData(token: token.refreshToken)
        else {
            return
        }
        
        let accessTokenAttributesWithData = self.accessTokenAttributes.merging(accessToken) { _, _ in }
        let fullRefreshTokenAttributesWithData = self.refreshTokenAttributes.merging(refreshToken) { _, _ in }
        
        let accessStatus = keychainManager.addItem(with: accessTokenAttributesWithData)
        let refreshStatus = keychainManager.addItem(with: fullRefreshTokenAttributesWithData)
        
        if accessStatus == errSecDuplicateItem || refreshStatus == errSecDuplicateItem {
            updateToken(with: token)
        }
    }
    
    func updateToken(with token: Token, completion: (() -> Void)? = nil) {
        guard let accessToken = convertTokenTokSecValueData(token: token.accessToken),
              let refreshToken = convertTokenTokSecValueData(token: token.refreshToken)
        else {
            return
        }
        
        let _ = keychainManager.updateItem(with: self.accessTokenAttributes, as: accessToken)

        let _ = keychainManager.updateItem(with: self.refreshTokenAttributes, as: refreshToken)
    }
    
    func fetchAccessToken() -> String? {
        let query = self.accessTokenAttributes.merging(fetchQuery) { _, _ in }
        
        let item = keychainManager.fetchItem(with: query)
        
        guard let data = item as? Data,
              let token = String(data: data, encoding: .utf8)
        else {
            return nil
        }
        
        return token
    }
    
    func fetchRefreshToken() -> String? {
        let query = self.refreshTokenAttributes.merging(fetchQuery) { _, _ in }
        
        let item = keychainManager.fetchItem(with: query)
        
        guard let data = item as? Data,
              let token = String(data: data, encoding: .utf8)
        else {
            return nil
        }
        
        return token
    }
    
    func deleteToken() {
        keychainManager.deleteItem(with: accessTokenAttributes)
        keychainManager.deleteItem(with: refreshTokenAttributes)
    }
}
