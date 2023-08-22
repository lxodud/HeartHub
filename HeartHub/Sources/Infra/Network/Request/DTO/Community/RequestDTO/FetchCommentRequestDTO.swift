//
//  FetchCommentRequestDTO.swift
//  HeartHub
//
//  Created by 이태영 on 2023/08/16.
//

import Foundation

struct FetchCommentRequestDTO: Encodable {
    let articleID: Int
    
    private enum CodingKeys: String, CodingKey {
        case articleID = "boardId"
    }
}
