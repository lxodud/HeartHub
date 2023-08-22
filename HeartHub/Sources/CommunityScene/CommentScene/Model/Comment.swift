//
//  Comment.swift
//  HeartHub
//
//  Created by 이태영 on 2023/08/19.
//

import Foundation

struct Comment: Decodable {
    let commentID: Int
    let username: String
    let content: String?
    let replyComment: [Comment]
    let userID: Int
    let heartCount: Int
    
    enum CodingKeys: String, CodingKey {
        case commentID = "commentId"
        case username = "userName"
        case content
        case replyComment = "responseList"
        case userID = "userId"
        case heartCount = "count"
    }
}
