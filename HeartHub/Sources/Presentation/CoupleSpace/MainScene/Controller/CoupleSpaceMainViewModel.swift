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
    
    private let coordinator: CoupleSpaceCoordinatable
    private let myInformationUseCase: MyInformationUseCaseType
    private let coupleInformationUseCase: CoupleInformationUseCaseType
    
    init(
        coordinator: CoupleSpaceCoordinatable,
        myInformationUseCase: MyInformationUseCaseType = MyInformationUseCase(),
        coupleInformationUseCase: CoupleInformationUseCaseType = CoupleInformationUseCase()
    ) {
        self.coordinator = coordinator
        self.myInformationUseCase = myInformationUseCase
        self.coupleInformationUseCase = coupleInformationUseCase
    }
}

// MARK: - Public Interface
extension CoupleSpaceMainViewModel {
    func transform(_ input: Input) -> Output {
        let isMateExist = input.viewDidLoad.flatMap {
            return self.coupleInformationUseCase.checkMateExist()
                .asDriver(onErrorJustReturn: false)
        }
        
        return Output(
            isMateExist: isMateExist
        )
    }
}
