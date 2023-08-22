//
//  ScrapArticleRequestDTO.swift
//  HeartHub
//
//  Created by 이태영 on 2023/08/16.
//

import Foundation

struct ScrapArticleRequestDTO: Encodable {
    let username: String
    let articleID: Int
    
    private enum CodingKeys: String, CodingKey {
        case username = "userName"
        case articleID = "boardId"
    }
}
