//
//  CommentLikeRequestDTO.swift
//  HeartHub
//
//  Created by 이태영 on 2023/08/16.
//

import Foundation

struct CommentLikeRequestDTO: Encodable {
    let commentID: Int
    
    private enum CodingKeys: String, CodingKey {
        case commentID = "commentId"
    }
}
