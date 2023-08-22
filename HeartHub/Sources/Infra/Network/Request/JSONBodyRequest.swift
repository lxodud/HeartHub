//
//  JSONBodyEndpoint.swift
//  HeartHub
//
//  Created by 이태영 on 2023/08/12.
//

import Foundation

struct JSONBodyRequest: JSONBodyRequestable {
    let baseURL: String
    let httpMethod: HTTPMethod
    let path: String
    let queryItems: [URLQueryItem]
    let headers: [String : String]
    let jsonBody: Encodable
    
    init(
        baseURL: String = "https://usus.shop",
        httpMethod: HTTPMethod,
        path: String = "",
        queryItems: [URLQueryItem] = [],
        headers: [String: String] = [:],
        jsonBody: Encodable
    ) {
        self.baseURL = baseURL
        self.httpMethod = httpMethod
        self.path = path
        self.queryItems = queryItems
        self.headers = headers
        self.jsonBody = jsonBody
    }
    
    func makeURLRequest() -> URLRequest? {
        guard let url = makeURL() else {
            return nil
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.allHTTPHeaderFields = headers
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpMethod = httpMethod.rawValue
        
        let body = try? JSONEncoder().encode(jsonBody)
        urlRequest.httpBody = body
        
        return urlRequest
    }
}
