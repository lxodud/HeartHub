//
//  StartDateInputViewModel.swift
//  HeartHub
//
//  Created by 이태영 on 2023/09/24.
//

import Foundation
import RxCocoa
import RxSwift

final class StartDateInputViewModel: ViewModelType {
    struct Input {
        let date: Observable<Date>
        let tapNext: Driver<Void>
    }
    
    struct Output {
        let formattedDate: Driver<String>
        let isNextEnable: Driver<Bool>
        let toNext: Driver<Void>
    }
    
    private let coordinator: SignUpCoordinatable
    private let signUpUseCase: SignUpUseCase

    // MARK: - initializer
    init(
        coordinator: SignUpCoordinatable,
        signUpUseCase: SignUpUseCase
    ) {
        self.coordinator = coordinator
        self.signUpUseCase = signUpUseCase
    }
}

// MARK: - Public Interface
extension StartDateInputViewModel {
    func transform(_ input: Input) -> Output {
        let formattedDate = input.date
            .do { self.signUpUseCase.startDate = $0 }
            .map { SignUpDateFormatter.shared.stringForPresentation(from: $0) }
            .asDriver(onErrorJustReturn: "")
        
        let isNextEnable = input.date
            .map{ _ in true }
            .startWith(false)
            .distinctUntilChanged()
            .asDriver(onErrorJustReturn: false)
        
        let toNext = input.tapNext
            .do { _ in self.coordinator.toAccountProfileInput() }
        
        return Output(
            formattedDate: formattedDate,
            isNextEnable: isNextEnable,
            toNext: toNext
        )
    }
}
