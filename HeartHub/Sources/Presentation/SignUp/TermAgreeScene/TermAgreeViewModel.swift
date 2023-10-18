//
//  TermAgreeViewModel.swift
//  HeartHub
//
//  Created by 이태영 on 2023/10/18.
//

import RxCocoa
import RxSwift
import Foundation

final class TermAgreeViewModel: ViewModelType {
    struct Input {
        let tapAllAgree: Driver<Void>
        let tapAgeTerm: Driver<Void>
        let tapPersonalInformationCollectionAndUsage: Driver<Void>
        let tapTermsOfUse: Driver<Void>
        let tapMarketingConsent: Driver<Void>
        let tapPersonalInformationCollectionAndUsageDetail: Driver<Void>
        let tapTermsOfUseDetail: Driver<Void>
    }
    
    struct Output {
        let isAllAgreeSelected: Driver<Bool>
        let isAgeTermSelected: Driver<Bool>
        let isPersonalInformationCollectionAndUsageSelected: Driver<Bool>
        let isTermsOfUse: Driver<Bool>
        let isMarketingConsent: Driver<Bool>
        let toPersonalInformationCollectionAndUsageDetail: Driver<Void>
        let toTermsOfUseDetail: Driver<Void>
    }
    
    private let coordinator: SignUpCoordinatable
    private let signUpUseCase: SignUpUseCaseType
    
    // MARK: - initializer
    init(
        coordinator: SignUpCoordinatable,
        signUpUseCase: SignUpUseCaseType
    ) {
        self.coordinator = coordinator
        self.signUpUseCase = signUpUseCase
    }
}

// MARK: - Public Interface
extension TermAgreeViewModel {
    func transform(_ input: Input) -> Output {
        let isAgeTermSelected = Driver.from([
            input.tapAgeTerm,
            input.tapAllAgree
        ])
            .merge()
            .scan(false) { state, _ in
                return !state
            }
            .distinctUntilChanged()
        
        let isPersonalInformationCollectionAndUsageSelected = Driver.from([
            input.tapPersonalInformationCollectionAndUsage,
            input.tapAllAgree
        ])
            .merge()
            .scan(false) { state, _ in
                return !state
            }
            .distinctUntilChanged()
        
        let isTermOfUse = Driver.from([
            input.tapTermsOfUse,
            input.tapAllAgree
        ])
            .merge()
            .scan(false) { state, _ in
                return !state
            }
            .distinctUntilChanged()
        
        let isMarketingConsent = Driver.from([
            input.tapMarketingConsent,
            input.tapAllAgree
        ])
            .merge()
            .scan(false) { state, _ in
                return !state
            }
            .distinctUntilChanged()
        
        let isAllAgreeSelected = Driver.combineLatest(
            isAgeTermSelected,
            isPersonalInformationCollectionAndUsageSelected,
            isTermOfUse, isMarketingConsent) {
                $0 && $1 && $2 && $3
            }
        
        let toPersonalInformationCollectionAndUsageDetail = input.tapPersonalInformationCollectionAndUsageDetail
            .do { _ in
                self.coordinator.toPersonalInformationCollectionAndUsageDetail()
            }
        
        let toTermsOfUseDetail = input.tapTermsOfUseDetail
            .do { _ in
                // TODO: 디테일로 화면 전환
            }
            
        return Output(
            isAllAgreeSelected: isAllAgreeSelected,
            isAgeTermSelected: isAgeTermSelected,
            isPersonalInformationCollectionAndUsageSelected: isPersonalInformationCollectionAndUsageSelected,
            isTermsOfUse: isTermOfUse,
            isMarketingConsent: isMarketingConsent,
            toPersonalInformationCollectionAndUsageDetail: toPersonalInformationCollectionAndUsageDetail,
            toTermsOfUseDetail: toTermsOfUseDetail
        )
    }
}
