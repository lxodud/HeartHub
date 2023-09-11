//
//  MyPageRequestBuilderFactory.swift
//  HeartHub
//
//  Created by 이태영 on 2023/09/10.
//

import Foundation

struct MyPageRequestBuilderFactory {
    static func makeModifyProfileRequestBuilder(
        imageData: Data,
        nickname: String
    ) throws -> MultipartBodyRequestBuilder<BasicResponseDTO> {
        let jsonData = try JSONSerialization.data(withJSONObject: ["userMessage": "", "userNickName": nickname])
        
        var multipartData = [
            ("request", UUID().uuidString, "application/json", jsonData)
        ]
        
        multipartData.append(("file", UUID().uuidString, "image/png", imageData))
        
        return MultipartBodyRequestBuilder(
            httpMethod: .put,
            path: "/api/user/myPage/update",
            multipartData: multipartData
        )
    }
}
