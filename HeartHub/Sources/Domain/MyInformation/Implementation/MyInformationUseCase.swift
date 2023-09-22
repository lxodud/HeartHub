//
//  MyInformationUseCase.swift
//  HeartHub
//
//  Created by 이태영 on 2023/09/10.
//

import Foundation
import RxSwift

final class MyInformationUseCase {
    private let myInformationRepository: MyInformationRepositoryType
    
    init(
        myInformationRepository: MyInformationRepositoryType = MyInformationRepository()
    ) {
        self.myInformationRepository = myInformationRepository
    }
}

// MARK: Public Interface
extension MyInformationUseCase: MyInformationUseCaseType {
    func editMyInformation(imageData: Data, nickname: String) -> Completable {
        let newInformation = UserInformation(profileImage: imageData, nickname: nickname)
        
        return myInformationRepository.upsertUserInformation(with: newInformation)
    }
    
    func fetchMyInformation() -> Observable<UserInformation> {
        return myInformationRepository.fetchUserInformation()
    }
}
