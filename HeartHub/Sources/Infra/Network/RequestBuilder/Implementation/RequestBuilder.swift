//
//  Endpoint.swift
//  HeartHub
//
//  Created by 이태영 on 2023/08/12.
//

import Foundation

struct RequestBuilder<R: Decodable>: RequestBuilderProtocol {
    typealias Response = R
    
    let baseURL: String
    let httpMethod: HTTPMethod
    let path: String
    let queryItems: [URLQueryItem]
    let headers: [String : String]
    let deserializer: NetworkDeserializable
    
    init(
        baseURL: String = "https://usus.shop",
        httpMethod: HTTPMethod,
        path: String = "",
        queryItems: [URLQueryItem] = [],
        headers: [String: String] = [:],
        deserializer: NetworkDeserializable = JSONNetworkDeserializer()
    ) {
        self.baseURL = baseURL
        self.httpMethod = httpMethod
        self.path = path
        self.queryItems = queryItems
        self.headers = headers
        self.deserializer = deserializer
    }
    
    func makeURLRequest() throws -> URLRequest? {
        guard let url = makeURL() else {
            return nil
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.allHTTPHeaderFields = headers
        urlRequest.httpMethod = httpMethod.rawValue
        
        return urlRequest
    }
}
