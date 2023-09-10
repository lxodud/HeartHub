//
//  UserRelatedRequestBuilderFactory.swift
//  HeartHub
//
//  Created by 이태영 on 2023/08/12.
//

import Foundation

struct UserRelatedRequestBuilderFactory {
    static func makeEmailCheckRequest(of email: String) -> RequestBuilder<CheckAvailabilityResponseDTO> {
        return RequestBuilder(
            httpMethod: .get,
            path: "/api/check/email/" + email
        )
    }
    
    static func makeIdCheckRequest(of id: String) -> RequestBuilder<CheckAvailabilityResponseDTO> {
        return RequestBuilder(
            httpMethod: .get,
            path: "/api/check/username/" + id
        )
    }
    
    static func makeNicknameCheckRequest(of nickname: String) -> RequestBuilder<CheckAvailabilityResponseDTO> {
        return RequestBuilder(
            httpMethod: .get,
            path: "/api/check/nickname/" + nickname
        )
    }
    
    static func makeVerificateEmailRequest(of email: String) -> RequestBuilder<EmailVerificationResponseDTO> {
        return RequestBuilder(
            httpMethod: .get,
            path: "/api/email-verification/\(email)"
        )
    }
    
    static func makeJoinRequest(of body: JoinRequestDTO) -> JSONBodyRequestBuilder<BasicResponseDTO> {
        return JSONBodyRequestBuilder(
            httpMethod: .post,
            path: "/api/join",
            jsonBody: body
        )
    }
    
    static func makeSignInRequest(of body: SignInRequestDTO) -> JSONBodyRequestBuilder<FetchTokenResponseDTO> {
        return JSONBodyRequestBuilder(
            httpMethod: .post,
            path: "/api/login",
            jsonBody: body
        )
    }
    
    static func makeGetDatingDateRequest() -> RequestBuilder<GetDatingDataResponseDTO> {
        return RequestBuilder(
            httpMethod: .get,
            path: "/api/user/datingDate",
            useAuthorization: true
        )
    }
    
    static func makeGetUserInformation(of id: Int) -> RequestBuilder<GetUserInformationResponseDTO> {
        return RequestBuilder(
            httpMethod: .get,
            path: "/api/user/info/" + id.description,
            useAuthorization: true
        )
    }
    
    static func makeCheckMateExistRequest() -> RequestBuilder<CheckMateExistResponseDTO> {
        return RequestBuilder(
            httpMethod: .get,
            path: "/api/user/exist-mate",
            useAuthorization: true
        )
    }
    
    static func makeSetMateRequest(of body: SetMateRequestDTO) -> JSONBodyRequestBuilder<CheckAvailabilityResponseDTO> {
        return JSONBodyRequestBuilder(
            httpMethod: .post,
            path: "/api/user/set/mate",
            jsonBody: body,
            useAuthorization: true
        )
    }
    
    static func makeFindUsernameRequest(of email: String) -> JSONBodyRequestBuilder<CheckAvailabilityResponseDTO> {
        return JSONBodyRequestBuilder(
            httpMethod: .post,
            path: "/api/find/username",
            jsonBody: email
        )
    }
    
    static func makeReissueTokenRequest(token: String) -> RequestBuilder<FetchReissueTokenResponseDTO> {
        return RequestBuilder(
            httpMethod: .post,
            path: "/api/member/reissue",
            headers: ["Authorization": "Bearer \(token)"]
        )
    }
    
    static func makeLogoutRequest() -> RequestBuilder<BasicResponseDTO> {
        return RequestBuilder(
            httpMethod: .post,
            path: "/api/member/logout",
            useAuthorization: true
        )
    }
    
    static func makeFindPasswordRequest(of body: FindPasswordRequestDTO) -> JSONBodyRequestBuilder<CheckAvailabilityResponseDTO> {
        return JSONBodyRequestBuilder(
            httpMethod: .post,
            path: "/api/find/passwd",
            jsonBody: body
        )
    }
    
    static func makeDeleteUserRequest() -> RequestBuilder<CheckAvailabilityResponseDTO> {
        return RequestBuilder(
            httpMethod: .post,
            path: "/api/member/delete/user",
            useAuthorization: true
        )
    }
    
    static func makeGetMyInformationRequest() -> RequestBuilder<GetMyInformationResponseDTO> {
        return RequestBuilder(
            httpMethod: .get,
            path: "/api/user/myPage/first",
            useAuthorization: true
        )
    }
}
