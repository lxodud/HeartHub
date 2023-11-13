//
//  CoupleSpaceRequestBuilderFactory.swift
//  HeartHub
//
//  Created by 이태영 on 2023/11/13.
//

import Foundation

struct CoupleSpaceRequestBuilderFactory {
    static func makePostAlbumRequest(
        image: Data,
        title: String,
        body: String
    ) throws -> MultipartBodyRequestBuilder<BasicResponseDTO> {
        let jsonData = try JSONSerialization.data(withJSONObject: ["title": title, "content": body])
        
        var multipartData = [
            ("requesDto", UUID().uuidString, "application/json", jsonData)
        ]
        
        multipartData.append(("files", UUID().uuidString, "image/png", image))
        
        return MultipartBodyRequestBuilder(
            httpMethod: .post,
            path: "/api/user/couple-board/write",
            multipartData: multipartData
        )
    }
}
