//
//  WithdrawalViewModel.swift
//  HeartHub
//
//  Created by 이태영 on 2023/09/12.
//

import Foundation
import RxCocoa
import RxSwift

final class WithdrawalViewModel: ViewModelType {
    struct Input {
        let tapCautionAgree: Driver<Void>
        let tapWithdraw: Driver<Void>
    }
    
    struct Output {
        let isAgreed: Driver<Bool>
        let canWithdraw: Driver<Bool>
        let withdrawing: Driver<Bool>
        let withdrawResult: Driver<Bool>
    }
    
    private let withdrawUseCase: WithdrawUseCaseType
    
    init(withdrawUseCase: WithdrawUseCaseType = WithdrawUseCase()) {
        self.withdrawUseCase = withdrawUseCase
    }
}

// MARK: - Public Interface
extension WithdrawalViewModel {
    func transform(_ input: Input) -> Output {
        let isAgreed = input.tapCautionAgree
            .scan(false) { state, _ in
                return !state
            }
        
        let withdrawResult = input.tapWithdraw
            .flatMap({
                return self.withdrawUseCase.withdraw()
                    .andThen(Observable<Bool>.just((true)))
                    .asDriver(onErrorJustReturn: false)
            })
        
        let withdrawing = Observable.from([
            input.tapWithdraw.map({ _ in true }),
            withdrawResult.map({ _ in false })
        ])
            .merge()
            .asDriver(onErrorJustReturn: false)
        
        let withdrawEnable = Observable.from([
            isAgreed,
            withdrawing.map({ !$0 }),
        ])
            .merge()
            .asDriver(onErrorJustReturn: false)
        
        return Output(
            isAgreed: isAgreed,
            canWithdraw: withdrawEnable,
            withdrawing: withdrawing,
            withdrawResult: withdrawResult
        )
    }
}
