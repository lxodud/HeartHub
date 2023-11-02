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
        let viewWillAppear: Driver<Void>
        let albumButtonTap: Driver<Void>
        let connectButtonTap: Driver<Void>
    }
     
    struct Output {
        let isMateExist: Driver<Bool>
//        let dday: Driver<String>
        let toAlbum: Driver<Void>
        let toConnect: Driver<Void>
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
        let isMateExist = input.viewWillAppear.flatMap {
            return self.coupleInformationUseCase.checkMateExist()
                .asDriver(onErrorJustReturn: false)
        }
        
        let toAlbum = input.albumButtonTap
            .do { _ in self.coordinator.toAlbum() }
        
        let toConnect = input.connectButtonTap
            .do { _ in self.coordinator.toConnect() }
        
        return Output(
            isMateExist: isMateExist,
            toAlbum: toAlbum,
            toConnect: toConnect
        )
    }
}
