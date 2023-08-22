//
//  Cancellable.swift
//  HeartHub
//
//  Created by 이태영 on 2023/08/22.
//

import Foundation

protocol Cancellable {
    func cancel()
}

extension URLSessionTask: Cancellable { }
