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

protocol RequestBuilderProtocol {
    associatedtype Response: Decodable
    
    var baseURL: String { get }
    var httpMethod: HTTPMethod { get }
    var path: String { get }
    var queryItems: [URLQueryItem] { get }
    var headers: [String: String] { get }
    var deserializer: any NetworkDeserializable { get }
    
    func makeURLRequest() throws -> URLRequest?
}

extension RequestBuilderProtocol {
    func makeURL() -> URL? {
        guard var component = URLComponents(string: baseURL) else {
            return nil
        }
        
        component.path = path
        component.queryItems = queryItems
        
        return component.url
    }
}
