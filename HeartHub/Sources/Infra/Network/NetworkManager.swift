//
//  NetworkManager.swift
//  HeartHub
//
//  Created by 이태영 on 2023/08/10.
//

import Foundation

protocol NetworkManager {
    @discardableResult
    func request<Builder: RequestBuilderProtocol>(
        _ builder: Builder,
        completion: @escaping (Result<Builder.Response, Error>) -> Void
     ) -> Cancellable?
}

final class DefaultNetworkManager: NetworkManager {
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
        _ builder: Builder,
        completion: @escaping (Result<Builder.Response, Error>) -> Void
    ) -> Cancellable? {
        guard var request = try? builder.makeURLRequest() else {
            // TODO: Error Handling
            return nil
        }

        if builder.useAuthorization,
           let accessToken = tokenRepository.fetchAccessToken()
        {
            request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        }
        
        let task: Cancellable
        
        let completionHandler: (Data?, URLResponse?, Error?) -> Void = { data, response, error in
            guard error == nil else {
                completion(.failure(NetworkError.transportError))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(NetworkError.transportError))
                return
            }
            
            guard (200...299) ~= httpResponse.statusCode else {
                guard let data = data,
                      let decodedData = try? JSONDecoder().decode(BasicResponseDTO.self, from: data),
                      decodedData.code == 3000
                else {
                    completion(.failure(NetworkError.requestFail(statusCode: httpResponse.statusCode)))
                    return
                }
                
                self.resolveExpireAccessToken {
                    self.request(builder, completion: completion)
                }
                
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.missingData))
                return
            }
            
            guard let decodedData: Builder.Response = try? builder.deserializer.deserialie(data) else {
                completion(.failure(NetworkError.decodingError))
                return
            }
            
            completion(.success(decodedData))
        }
        
        if let body = request.httpBody {
            task = uploadData(request: request, body: body, completion: completionHandler)
        } else {
            task = requestData(request: request, completion: completionHandler)
        }
        
        return task
    }
    
    private func requestData(
        request: URLRequest,
        completion: @escaping (Data?, URLResponse?, Error?) -> Void
    ) -> Cancellable {
        let task = session.dataTask(with: request) { data, response, error in
            completion(data, response, error)
        }
        
        task.resume()
        
        return task
    }
    
    private func uploadData(
        request: URLRequest,
        body: Data,
        completion: @escaping (Data?, URLResponse?, Error?) -> Void
    ) -> Cancellable {
        let task = session.uploadTask(with: request, from: body) { data, response, error in
            completion(data, response, error)
        }
        
        task.resume()
        
        return task
    }
    
    private func resolveExpireAccessToken(completion: @escaping () -> Void) {
        guard let refreshToken = tokenRepository.fetchRefreshToken() else {
            return
        }
        
        let builder = UserRelatedRequestBuilderFactory.makeReissueTokenRequest(token: refreshToken)
        
        request(builder) { result in
            switch result {
            case .success(let data):
                let token = data.data
                
                let accessToken = token.newAccessToken
                let refreshToken = token.newRefreshToken
                let newToken = Token(accessToken: accessToken, refreshToken: refreshToken)
                
                self.tokenRepository.saveToken(with: newToken)
                completion()
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
