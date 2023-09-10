//
//  JSONBodyRequestBuilder.swift
//  HeartHub
//
//  Created by 이태영 on 2023/09/10.
//

import Foundation

struct JSONBodyRequestBuilder<R: Decodable>: RequestBuilderProtocol {
    typealias Response = R
    
    let baseURL: String
    let httpMethod: HTTPMethod
    let path: String
    let queryItems: [URLQueryItem]
    let headers: [String : String]
    let deserializer: NetworkDeserializable
    let jsonBody: Encodable
    let useAuthorization: Bool

    init(
        baseURL: String = "https://usus.shop",
        httpMethod: HTTPMethod,
        path: String = "",
        queryItems: [URLQueryItem] = [],
        headers: [String: String] = [:],
        deserializer: NetworkDeserializable = JSONNetworkDeserializer(),
        jsonBody: Encodable,
        useAuthorization: Bool = false
    ) {
        self.baseURL = baseURL
        self.httpMethod = httpMethod
        self.path = path
        self.queryItems = queryItems
        self.headers = headers
        self.deserializer = deserializer
        self.jsonBody = jsonBody
        self.useAuthorization = useAuthorization
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
