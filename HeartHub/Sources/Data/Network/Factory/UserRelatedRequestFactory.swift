//
//  UserRelatedRequestFactory.swift
//  HeartHub
//
//  Created by 이태영 on 2023/08/12.
//

import Foundation

struct UserRelatedRequestFactory {
    static func makeEmailCheckRequest(of email: String) -> Requestable {
        return Request(
            httpMethod: .get,
            path: "/api/check/email/" + email
        )
    }
    
    static func makeIdCheckRequest(of id: String) -> Requestable {
        return Request(
            httpMethod: .get,
            path: "/api/check/username/" + id
        )
    }
    
    static func makeNicknameCheckRequest(of nickname: String) -> Requestable {
        return Request(
            httpMethod: .get,
            path: "/api/check/nickname/" + nickname
        )
    }
    
    static func makeVerificateEmailRequest(of email: String) -> Requestable {
        return Request(
            httpMethod: .get,
            path: "/api/email-verification/\(email)"
        )
    }
    
    static func makeJoinRequest(of body: JoinRequestDTO) -> Requestable {
        return JSONBodyRequest(
            httpMethod: .post,
            path: "/api/join",
            jsonBody: body
        )
    }
    
    static func makeSignInRequest(of body: SignInRequestDTO) -> Requestable {
        return JSONBodyRequest(
            httpMethod: .post,
            path: "/api/login",
            jsonBody: body
        )
    }
    
    static func makeGetDatingDateRequest(token: String) -> Requestable {
        return Request(
            httpMethod: .get,
            path: "/api/user/datingDate",
            headers: ["Authorization": "Bearer " + token]
        )
    }
    
    static func makeGetUserInformation(of id: Int, token: String) -> Requestable {
        return Request(
            httpMethod: .get,
            path: "/api/user/info/" + id.description,
            headers: ["Authorization": "Bearer " + token]
        )
    }
    
    static func makeCheckMateExistRequest(token: String) -> Requestable {
        return Request(
            httpMethod: .get,
            path: "/api/user/exist-mate",
            headers: ["Authorization": token]
        )
    }
    
    static func makeSetMateRequest(of body: SetMateRequestDTO, token: String) -> Requestable {
        return JSONBodyRequest(
            httpMethod: .post,
            path: "/api/user/set/mate",
            headers: ["Authorization": "Bearer " + token],
            jsonBody: body
        )
    }
    
    static func makeFindUsernameRequest(of body: FindUsernameRequestDTO) -> Requestable {
        return JSONBodyRequest(
            httpMethod: .post,
            path: "/api/find/username",
            jsonBody: body
        )
    }
    
    static func makeReissueTokenRequest(token: String) -> Requestable {
        return Request(
            httpMethod: .post,
            path: "/api/member/reissue",
            headers: ["Authorization": "Bearer " + token]
        )
    }
    
    static func makeLogoutRequest(token: String) -> Requestable {
        return Request(
            httpMethod: .post,
            path: "/api/member/logout",
            headers: ["Authorization": "Bearer " + token]
        )
    }
    
    static func makeFindPasswordRequest(of body: FindPasswordRequestDTO) -> Requestable {
        return JSONBodyRequest(
            httpMethod: .post,
            path: "/api/find/passwd",
            jsonBody: body
        )
    }
    
    static func makeDeleteUserRequest(token: String) -> Requestable {
        return Request(
            httpMethod: .post,
            path: "/api/member/delete/user",
            headers: ["Authorization": "Bearer " + token]
        )
    }
    
    static func makeGetMyInformationRequest(token: String) -> Requestable {
        return Request(
            httpMethod: .get,
            path: "/api/user/myPage/first",
            headers: ["Authorization": "Bearer " + token]
        )
    }
}
