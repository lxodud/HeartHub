//
//  PostArticleRequestDTO.swift
//  HeartHub
//
//  Created by 이태영 on 2023/08/16.
//

import Foundation

struct PostArticleRequestDTO: Encodable {
    let content: String
    let theme: ArticleTheme
    let userName: String
}
