//
//  MyInformationService.swift
//  HeartHub
//
//  Created by 이태영 on 2023/09/10.
//

import Foundation

final class MyInformationService {
    private let myInformationRepository: MyInformationRepository
    private let networkManager: NetworkManager
    
    init(
        myInformationRepository: MyInformationRepository = MyInformationRepository(),
        networkManager: NetworkManager = DefaultNetworkManager()
    ) {
        self.myInformationRepository = myInformationRepository
        self.networkManager = networkManager
    }
}

// MARK: Public Interface
extension MyInformationService {
    func fetchProfileImage() -> Data? {
        return myInformationRepository.fetchProfileImage()
    }
    
    func fetchNickname() -> String? {
        return myInformationRepository.fetchNickname()
    }
    
    func fetchUsername() -> String? {
        return myInformationRepository.fetchUsername()
    }
    
    func removeMyInformation() {
        myInformationRepository.removeAllInformation()
    }
    
    func editMyInformation(
        imageData: Data,
        nickname: String,
        completion: @escaping (Result<Void, Error>) -> Void
    ) {
        do {
            let builder = try MyPageRequestBuilderFactory.makeModifyProfileRequestBuilder(
                imageData: imageData,
                nickname: nickname
            )
            
            networkManager.request(builder) { result in
                switch result {
                case .success(_):
                    completion(.success(()))
                    self.myInformationRepository.saveProfileImage(with: imageData)
                    self.myInformationRepository.saveNickname(with: nickname)
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        } catch {
            completion(.failure(error))
        }
    }
}
