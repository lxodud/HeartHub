//
//  NetworkSerializable.swift
//  HeartHub
//
//  Created by 이태영 on 2023/09/09.
//

import Foundation

protocol NetworkSerializable {
    associatedtype Object
    
    func serialize(_ value: Object) throws -> Data
}
