//
//  ConnectViewModel.swift
//  HeartHub
//
//  Created by 이태영 on 2023/11/05.
//

import Foundation
import RxCocoa
import RxSwift

final class ConnectViewModel: ViewModelType {
    struct Input {
        let id: Driver<String>
        let tapFindMate: Driver<Void>
    }
    
    struct Output {
        let isFindMateEnable: Driver<Bool>
        let toMateInformation: Driver<Void>
    }
    
    private let coordinator: ConnectCoordinatable
    
    // MARK: - initializer
    init(
        coordinator: ConnectCoordinatable,
        coupleInformationUseCase: CoupleInformationUseCaseType = CoupleInformationUseCase()
    ) {
        self.coordinator = coordinator
    }
}

// MARK: - Public Interface
extension ConnectViewModel {
    func transform(_ input: Input) -> Output {
        let isFindMateEnable = input.id
            .map { !$0.isEmpty }
        
        let toMateInformation = input.tapFindMate.withLatestFrom(input.id)
            .do {
                self.coordinator.toMateInformation($0)
            }
            .map { _ in }

        return Output(
            isFindMateEnable: isFindMateEnable,
            toMateInformation: toMateInformation
        )
    }
}
