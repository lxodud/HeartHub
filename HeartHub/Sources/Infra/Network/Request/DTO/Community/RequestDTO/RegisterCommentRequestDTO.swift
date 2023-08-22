//
//  RegisterCommentRequestDTO.swift
//  HeartHub
//
//  Created by 이태영 on 2023/08/16.
//

import Foundation

struct RegisterCommentRequestDTO: Encodable {
    let articleID: Int
    let username: String
    let content: String
    let parentID: Int?
    
    private enum CodingKeys: String, CodingKey {
        case articleID = "boardId"
        case username = "userName"
        case content
        case parentID = "parentId"
    }
}
