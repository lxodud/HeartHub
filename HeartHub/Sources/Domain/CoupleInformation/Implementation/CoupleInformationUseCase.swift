//
//  CoupleInformationUseCase.swift
//  HeartHub
//
//  Created by 이태영 on 2023/10/30.
//

import RxSwift

final class CoupleInformationUseCase {
    private let coupleInformationRepository: CoupleInformationRepositoryType
    
    init(coupleInformationRepository: CoupleInformationRepositoryType = CoupleInformationRepository()) {
        self.coupleInformationRepository = coupleInformationRepository
    }
}

extension CoupleInformationUseCase: CoupleInformationUseCaseType {
    func checkMateExist() -> Observable<Bool> {
        return coupleInformationRepository.checkMateExist()
    }
}
