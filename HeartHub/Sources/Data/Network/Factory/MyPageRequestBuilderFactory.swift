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
            ("params", UUID().uuidString, "application/json", jsonData)
        ]
        
        multipartData.append(("files", UUID().uuidString, "image/png", imageData))
        
        return MultipartBodyRequestBuilder(
            httpMethod: .post,
            path: "/api/user/myPage/update",
            multipartData: multipartData
        )
    }
}
