//
//  CancleCommentLikeRequestDTO.swift
//  HeartHub
//
//  Created by 이태영 on 2023/08/16.
//

import Foundation

struct CancleCommentLikeRequestDTO: Encodable {
    let username: String
    let commentID: Int
    
    private enum CodingKeys: String, CodingKey {
        case username = "userName"
        case commentID = "commentId"
    }
}
