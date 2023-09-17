//
//  ImageProvider.swift
//  HeartHub
//
//  Created by 이태영 on 2023/08/21.
//

import Foundation
import RxSwift

final class ImageProvider {
    static let shared = ImageProvider()
    
    private init() { }
    
    @discardableResult
    func fetch(
        from url: URL,
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
                completion(.failure(NetworkError.requestFail(statusCode: httpResponse.statusCode)))
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

final class RxImageProvider {
    static let shared = RxImageProvider()
    
    private init() { }
    
    func fetch(
        from url: URL
    ) -> Observable<Data> {
        return Observable.create { emitter in
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                guard error == nil else {
                    emitter.onError(NetworkError.transportError)
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse else {
                    emitter.onError(NetworkError.transportError)
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
                
                emitter.onNext(data)
            }
            
            task.resume()
            
            return Disposables.create {
                task.cancel()
            }
        }
    }
}
