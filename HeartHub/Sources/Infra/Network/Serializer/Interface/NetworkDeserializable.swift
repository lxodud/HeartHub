//
//  NetworkDeserializable.swift
//  HeartHub
//
//  Created by 이태영 on 2023/09/09.
//

import Foundation

protocol NetworkDeserializable {
    func deserialie<T: Decodable>(_ data: Data) throws -> T
}
