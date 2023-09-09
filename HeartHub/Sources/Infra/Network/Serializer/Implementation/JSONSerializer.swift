//
//  JSONSerializer.swift
//  HeartHub
//
//  Created by 이태영 on 2023/09/09.
//

import Foundation

struct JSONSerializer: NetworkSerializable {
    private let encoder: JSONEncoder
    
    init(encoder: JSONEncoder) {
        self.encoder = encoder
    }
    
    func serialize(_ value: Encodable) throws -> Data {
        return try encoder.encode(value)
    }
}
