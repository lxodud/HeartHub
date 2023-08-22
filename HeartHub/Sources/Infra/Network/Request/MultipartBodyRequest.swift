//
//  MultipartBodyRequest.swift
//  HeartHub
//
//  Created by 이태영 on 2023/08/14.
//

import Foundation

struct MultipartBodyRequest: MultipartBodyRequestable {
    let baseURL: String
    let httpMethod: HTTPMethod
    let path: String
    let queryItems: [URLQueryItem]
    let headers: [String : String]
    let boundary: UUID
    let multipartData: [(fieldName: String, fileName: String, mimeType: String, data: Data)]
    
    init(
        baseURL: String = "https://usus.shop",
        httpMethod: HTTPMethod,
        path: String = "",
        queryItems: [URLQueryItem] = [],
        headers: [String: String] = [:],
        boundary: UUID = UUID(),
        multipartData: [(fieldName: String, fileName: String, mimeType: String, data: Data)]
    ) {
        self.baseURL = baseURL
        self.httpMethod = httpMethod
        self.path = path
        self.queryItems = queryItems
        self.headers = headers
        self.boundary = boundary
        self.multipartData = multipartData
    }
    
    func makeURLRequest() -> URLRequest? {
        guard let url = makeURL() else {
            return nil
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.allHTTPHeaderFields = headers
        urlRequest.setValue(
            "multipart/form-data; boundary=\(boundary.uuidString)",
            forHTTPHeaderField: "Content-Type"
        )
        urlRequest.httpMethod = httpMethod.rawValue
        
        var requestData = Data()
        
        for data in multipartData {
            requestData.appendString("--\(boundary.uuidString)\r\n")
            requestData.appendString("Content-Disposition: form-data; name=\"\(data.fieldName)\"; filename=\"\(data.fileName)\"\r\n")
            requestData.appendString("Content-Type: \(data.mimeType)\r\n\r\n")
            requestData.append(data.data)
            requestData.appendString("\r\n")
        }
        
        requestData.appendString("\r\n--\(boundary.uuidString)--\r\n")
        
        urlRequest.httpBody = requestData
        
        return urlRequest
    }
}

extension Data {
    mutating func appendString(_ input: String) {
        if let input = input.data(using: .utf8) {
            self.append(input)
        }
    }
}
