//
//  CoupleSpaceMainViewModel.swift
//  HeartHub
//
//  Created by 이태영 on 2023/10/29.
//

import Foundation
import RxCocoa
import RxSwift

final class CoupleSpaceMainViewModel: ViewModelType {
    struct Input {
        let viewDidLoad: Driver<Void>
    }
     
    struct Output {
        let isMateExist: Driver<Bool>
    }
    
    private let myInformationUseCase: MyInformationUseCaseType
    private let coupleInformationUseCase: CoupleInformationUseCaseType
    
    init(
        myInformationUseCase: MyInformationUseCaseType = MyInformationUseCase(),
        coupleInformationUseCase: CoupleInformationUseCaseType = CoupleInformationUseCase()
    ) {
        self.myInformationUseCase = myInformationUseCase
        self.coupleInformationUseCase = coupleInformationUseCase
    }
}

// MARK: - Public Interface
extension CoupleSpaceMainViewModel {
    func transform(_ input: Input) -> Output {
//        let myProfileImage = input.viewDidLoad.flatMap {
//            return  self.myInformationUseCase
//                .fetchMyInformation()
//                .map { $0.profileImage }
//                .asDriver(onErrorJustReturn: Data())
//        }
        
        let isMateExist = input.viewDidLoad.flatMap {
            return self.coupleInformationUseCase.checkMateExist()
                .debug()
                .asDriver(onErrorJustReturn: false)
        }
        
        return Output(
            isMateExist: isMateExist
        )
    }
}
