//
//  KeychainManager.swift
//  HeartHub
//
//  Created by 이태영 on 2023/08/13.
//

import Foundation

final class KeychainManager {
    
}

// MARK: Public Interface
extension KeychainManager {
    @discardableResult
    func fetchItem(
        with query: [String: Any]
    ) -> AnyObject? {
        var item: CFTypeRef?
        let _ = SecItemCopyMatching(query as CFDictionary, &item)
        return item
    }
    
    @discardableResult
    func addItem(
        with attributes: [String: Any]
    ) -> OSStatus {
        let status = SecItemAdd(attributes as CFDictionary, nil)
        return status
        
    }
    
    @discardableResult
    func updateItem(
        with query: [String: Any],
        as attributes: [String: Any]
    ) -> OSStatus {
        let status = SecItemUpdate(query as CFDictionary, attributes as CFDictionary)
        return status
    }
    
    @discardableResult
    func deleteItem(
        with query: [String: Any]
    ) -> OSStatus {
        let status = SecItemDelete(query as CFDictionary)
        print(status)
        return status
    }
}
