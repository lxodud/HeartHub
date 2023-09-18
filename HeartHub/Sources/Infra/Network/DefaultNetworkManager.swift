//
//  DefaultNetworkManager.swift
//  HeartHub
//
//  Created by 이태영 on 2023/09/18.
//

import Foundation
import RxSwift

protocol RxNetworkManager {
    @discardableResult
    func request<Builder: RequestBuilderProtocol>(
        _ builder: Builder
    ) -> Observable<Builder.Response>
}

final class DefaultRxNetworkManager: RxNetworkManager {
    private let session: URLSession
    private let tokenRepository: TokenRepository
    
    init(
        session: URLSession = URLSession.shared,
        tokenRepository: TokenRepository = TokenRepository()
    ) {
        self.session = session
        self.tokenRepository = tokenRepository
    }
    
    @discardableResult
    func request<Builder: RequestBuilderProtocol>(
        _ builder: Builder
    ) -> Observable<Builder.Response> {
        guard var request = try? builder.makeURLRequest() else {
            return Observable.error(NetworkError.invalidRequest)
        }

        if builder.useAuthorization,
           let accessToken = tokenRepository.fetchAccessToken()
        {
            request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        }
        
        return Observable.create { emitter in
            let task = self.session.dataTask(with: request) { data, response, error in
                guard error == nil else {
                    emitter.onError(NetworkError.transportError)
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse else {
                    emitter.onError(NetworkError.translateResponseError)
                    return
                }
                
                guard (200...299) ~= httpResponse.statusCode else {
                    emitter.onError(NetworkError.requestFail(statusCode: httpResponse.statusCode))
                    return
                }
                
                guard let data = data else {
                    emitter.onError(NetworkError.missingData)
                    return
                }
                
                guard let decodedData: Builder.Response = try? builder.deserializer.deserialie(data) else {
                    emitter.onError(NetworkError.decodingError)
                    return
                }
                
                emitter.onNext(decodedData)
            }
            
            task.resume()
            
            return Disposables.create {
                task.cancel()
            }
        }
    }
}
