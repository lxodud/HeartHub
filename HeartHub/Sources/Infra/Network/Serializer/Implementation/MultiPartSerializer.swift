//
//  MultiPartSerializer.swift
//  HeartHub
//
//  Created by 이태영 on 2023/09/09.
//

import Foundation

typealias MultiPartDataForm = [(fieldName: String, fileName: String, mimeType: String, data: Data)]

struct MultiPartSerializer: NetworkSerializable {
    private let boundary = UUID()
    func serialize(
        _ value: MultiPartDataForm
    ) -> Data {
        var requestData = Data()
        
        for data in value {
            requestData.appendString("--\(boundary.uuidString)\r\n")
            requestData.appendString("Content-Disposition: form-data; name=\"\(data.fieldName)\"; filename=\"\(data.fileName)\"\r\n")
            requestData.appendString("Content-Type: \(data.mimeType)\r\n\r\n")
            requestData.append(data.data)
            requestData.appendString("\r\n")
        }
        
        requestData.appendString("\r\n--\(boundary.uuidString)--\r\n")
        
        return requestData
    }
}
