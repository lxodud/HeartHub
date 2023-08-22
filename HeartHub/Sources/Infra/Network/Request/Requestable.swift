//
//  Requestable.swift
//  HeartHub
//
//  Created by 이태영 on 2023/08/10.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

protocol Requestable {
    var baseURL: String { get }
    var httpMethod: HTTPMethod { get }
    var path: String { get }
    var queryItems: [URLQueryItem] { get }
    var headers: [String: String] { get }
    
    func makeURLRequest() -> URLRequest?
}

extension Requestable {
    func makeURL() -> URL? {
        guard var component = URLComponents(string: baseURL) else {
            return nil
        }
        
        component.path = path
        component.queryItems = queryItems
        
        return component.url
    }
}

protocol JSONBodyRequestable: Requestable {
    var jsonBody: Encodable { get }
}

protocol MultipartBodyRequestable: Requestable {
    var multipartData: [(fieldName: String, fileName: String, mimeType: String, data: Data)] { get }
    var boundary: UUID { get }
}

