//
//  JSONDeserializer.swift
//  HeartHub
//
//  Created by 이태영 on 2023/09/09.
//

import Foundation

struct JSONNetworkDeserializer: NetworkDeserializable {
    private let decoder: JSONDecoder
    
    init(decoder: JSONDecoder = JSONDecoder()) {
        self.decoder = decoder
    }
    
    func deserialie<T>(_ data: Data) throws -> T where T : Decodable {
        return try decoder.decode(T.self, from: data)
    }
}
