//
//  NetworkError.swift
//  HeartHub
//
//  Created by 이태영 on 2023/08/17.
//

import Foundation

enum NetworkError: Error {
    case transportError
    case translateResponseError
    case requestFail(statusCode: Int, data: Data?)
    case missingData
}

extension NetworkError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .transportError:
            return NSLocalizedString("transport error", comment: "transport error")
        case .translateResponseError:
            return NSLocalizedString("translate response error", comment: "translate response error")
        case .requestFail(let statusCode, _):
            return NSLocalizedString("requestFailError error: \(statusCode)", comment: "server error")
        case .missingData:
            return NSLocalizedString("missing data", comment: "missing data")
        }
    }
}
