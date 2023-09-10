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
    
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    @discardableResult
    func request<Builder: RequestBuilderProtocol>(
        _ builder: Builder,
        completion: @escaping (Result<Builder.Response, Error>) -> Void
    ) -> Cancellable? {
        guard let request = try? builder.makeURLRequest() else {
            // TODO: Error Handling
            return nil
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
                completion(.failure(NetworkError.requestFail(statusCode: httpResponse.statusCode, data: data)))
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
}
