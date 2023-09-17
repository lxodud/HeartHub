//
//  NetworkError.swift
//  HeartHub
//
//  Created by 이태영 on 2023/08/17.
//

import Foundation

enum NetworkError: Error {
    case invalidRequest
    case transportError
    case translateResponseError
    case requestFail(statusCode: Int)
    case missingData
    case decodingError
}

extension NetworkError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .transportError:
            return NSLocalizedString("transport error", comment: "transport error")
        case .translateResponseError:
            return NSLocalizedString("translate response error", comment: "translate response error")
        case .requestFail(let statusCode):
            return NSLocalizedString("requestFailError error: \(statusCode)", comment: "server error")
        case .missingData:
            return NSLocalizedString("missing data", comment: "missing data")
        case .decodingError:
            return NSLocalizedString("decoding error", comment: "decoding error")
        case .invalidRequest:
            return NSLocalizedString("invalid Request", comment: "invalid Request")
        }
    }
}
