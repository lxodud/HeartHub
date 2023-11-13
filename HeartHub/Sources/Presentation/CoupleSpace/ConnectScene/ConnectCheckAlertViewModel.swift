//
//  ConnectCheckAlertViewModel.swift
//  HeartHub
//
//  Created by 이태영 on 2023/11/06.
//

import Foundation
import RxCocoa
import RxSwift

final class ConnectCheckViewModel: ViewModelType {
    struct Input {
        let viewWillAppear: Driver<Void>
        let tapCancel: Driver<Void>
        let tapMatching: Driver<Void>
    }
    
    struct Output {
        let profileImage: Driver<Data>
        let nickname: Driver<String>
        let connectSuccess: Driver<Void>
        let cancel: Driver<Void>
    }
    
    private let id: String
    private let coordinator: ConnectCoordinatable
    private let coupleInformationUseCase: CoupleInformationUseCaseType
    
    init(
        id: String,
        coordinator: ConnectCoordinatable,
        coupleInformationUseCase: CoupleInformationUseCaseType = CoupleInformationUseCase()
    ) {
        self.id = id
        self.coordinator = coordinator
        self.coupleInformationUseCase = coupleInformationUseCase
    }
}

// MARK: Public Interface
extension ConnectCheckViewModel {
    func transform(_ input: Input) -> Output {
        let mateInformation = input.viewWillAppear
            .flatMap { _ in
                return self.coupleInformationUseCase.fetchMateInformation()
                    .asDriver(
                        onErrorJustReturn: UserInformation(profileImage: mateProfileImage, nickname: "james")
                    )
            }
        
        let profileImage = mateInformation.map { $0.profileImage }
        let nickname = mateInformation.map { $0.nickname }
        
        let connectSuccess = input.tapMatching
            .do { _ in self.coordinator.toSuccessAlert() }
        
        let cancel = input.tapCancel
            .do { _ in self.coordinator.cancel() }
        
        return Output(
            profileImage: profileImage,
            nickname: nickname,
            connectSuccess: connectSuccess,
            cancel: cancel
        )
    }
}
