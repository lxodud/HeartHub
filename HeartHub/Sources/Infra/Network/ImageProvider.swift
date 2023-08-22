//
//  ImageProvider.swift
//  HeartHub
//
//  Created by 이태영 on 2023/08/21.
//

import Foundation

final class ImageProvider {
    static let shared = ImageProvider()
    
    @discardableResult
    func fetch(
        from url: URL,
        queue: DispatchQueue = DispatchQueue.global(),
        completion: @escaping (Result<Data, Error>) -> Void
    ) -> Cancellable {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
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
            
            completion(.success(data))
        }
        
        task.resume()
        
        return task
    }
}
