//
//  CommunityRequestFactory.swift
//  HeartHub
//
//  Created by 이태영 on 2023/08/15.
//

import Foundation

struct CommunityRequestFactory {
    static func makePostArticleRequest(
        articleContent: PostArticleRequestDTO,
        imageData: [Data],
        token: String
    ) -> Requestable? {
        guard let jsonData = try? JSONEncoder().encode(articleContent) else {
            return nil
        }
        
        var multipartData = [
            ("params", UUID().uuidString, "application/json", jsonData)
        ]
        
        imageData.forEach {
            multipartData.append(("files", UUID().uuidString, "image/png", $0))
        }
        
        return MultipartBodyRequest(
            httpMethod: .post,
            path: "/api/user/board/articles/write",
            headers: ["Authorization": "Bearer " + token],
            multipartData: multipartData
        )
    }
    
    static func makeFetchCommunityArticleRequest(
        with theme: ArticleTheme,
        token: String
    ) -> Requestable {
        return Request(
            httpMethod: .get,
            path: "/api/user/board/\(theme.rawValue)/articles",
            headers: ["Authorization": "Bearer " + token]
        )
    }
    
    static func makeFetchCommunityArticleDetailRequest(
        with articleID: Int,
        token: String
    ) -> Requestable {
        return Request(
            httpMethod: .get,
            path: "/api/user/board/articles/\(articleID)",
            headers: ["Authorization": "Bearer " + token]
        )
    }
    
    static func makePostArticleGoodRequest(
        username: String,
        articleID: Int,
        token: String
    ) -> Requestable {
        return JSONBodyRequest(
            httpMethod: .post,
            path: "/api/user/board/\(articleID)/good",
            headers: ["Authorization": "Bearer " + token],
            jsonBody: PostArticleLikeRequestDTO(username: username)
        )
    }
    
    static func makeFetchArticleLikeCountRequest(
        with articleID: Int,
        token: String
    ) -> Requestable {
        return Request(
            httpMethod: .get,
            path: "/api/user/board/\(articleID)/good/count",
            headers: ["Authorization": "Bearer " + token]
        )
    }
    
    static func makeScrapArticleRequest(
        with scrapArticleInformation: ScrapArticleRequestDTO,
        token: String
    ) -> Requestable? {
        guard let jsonData = try? JSONEncoder().encode(scrapArticleInformation) else {
            return nil
        }
        
        let multipartData = [
            ("params", UUID().uuidString, "application/json", jsonData)
        ]

        return MultipartBodyRequest(
            httpMethod: .post,
            path: "/api/user/board/heart",
            headers: ["Authorization": "Bearer " + token],
            multipartData: multipartData
        )
    }
    
    static func makeDeleteArticleRequest(
        with articleID: Int,
        token: String
    ) -> Requestable {
        return Request(
            httpMethod: .delete,
            path: "/api/user/board/articles/\(articleID)",
            headers: ["Authorization": "Bearer " + token]
        )
    }
    
    static func makeFetchLookRankingRequest(
        token: String
    ) -> Requestable {
        return Request(
            httpMethod: .get,
            path: "/api/user/board/look/lank",
            headers: ["Authorization": "Bearer " + token]
        )
    }
    
    static func makeFetchCommentRequest(
        with articleID: Int,
        token: String
    ) -> Requestable {
        return Request(
            httpMethod: .get,
            path: "/api/user/board/\(articleID)/comments",
            headers: ["Authorization": "Bearer " + token]
        )
    }
    
    static func makeRegisterCommentRequest(
        with commentInformation: RegisterCommentRequestDTO,
        token: String
    ) -> Requestable {
        return JSONBodyRequest(
            httpMethod: .post,
            path: "/api/user/boardId/comments",
            headers: ["Authorization": "Bearer " + token],
            jsonBody: commentInformation
        )
    }
    
    static func makeDeleteCommentRequest(
        with commentID: Int,
        token: String
    ) -> Requestable {
        return JSONBodyRequest(
            httpMethod: .delete,
            path: "/api/user/board",
            headers: ["Authorization": "Bearer " + token],
            jsonBody: DeleteCommentRequestDTO(commentID: commentID)
        )
    }
    
    static func makeCommentLikeRequest(
        with commentID: Int,
        token: String
    ) -> Requestable {
        return JSONBodyRequest(
            httpMethod: .post,
            path: "/api/user/board/comment/good",
            headers: ["Authorization": "Bearer " + token],
            jsonBody: CommentLikeRequestDTO(commentID: commentID)
        )
    }
    
    static func makeFetchCommentLikeCountRequest(
        with commentID: Int,
        token: String
    ) -> Requestable {
        return Request(
            httpMethod: .get,
            path: "/api/user/board/comment/\(commentID)/counts",
            headers: ["Authorization": "Bearer " + token]
        )
    }
    
    static func makeCancleCommentLikeRequest(
        with body: CancleCommentLikeRequestDTO,
        token: String
    ) -> Requestable {
        return JSONBodyRequest(
            httpMethod: .delete,
            path: "/api/user/board/comment/unGood",
            headers: ["Authorization": "Bearer " + token],
            jsonBody: body
        )
    }
    
    static func makeFetchGoodStatusRequest(
        with articleID: Int,
        token: String
    ) -> Requestable {
        return Request(
            httpMethod: .get,
            path: "/api/user/board/\(articleID)/good/check",
            headers: ["Authorization": "Bearer " + token]
        )
    }
    
    static func makeFetchHeartStatusRequest(
        with articleID: Int,
        token: String
    ) -> Requestable {
        return Request(
            httpMethod: .get,
            path: "/api/user/board/\(articleID)/heart/check",
            headers: ["Authorization": "Bearer " + token]
        )
    }
    
    static func makeFetchCommentHeartStatusRequest(
        with commentID: Int,
        token: String
    ) -> Requestable {
        return Request(
            httpMethod: .get,
            path: "/api/user/board/comment/\(commentID)/good/check",
            headers: ["Authorization": "Bearer " + token]
        )
    }
}
