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
        let tapSignUp: Driver<Void>
    }
    
    struct Output {
        let isAllAgreeSelected: Driver<Bool>
        let isAgeTermSelected: Driver<Bool>
        let isPersonalInformationCollectionAndUsageSelected: Driver<Bool>
        let isTermsOfUse: Driver<Bool>
        let isMarketingConsent: Driver<Bool>
        let toPersonalInformationCollectionAndUsageDetail: Driver<Void>
        let toTermsOfUseDetail: Driver<Void>
        let isSignUpEnable: Driver<Bool>
        let signingUp: Driver<Bool>
        let signedUp: Driver<Void>
    }
    
    private let coordinator: SignUpCoordinatable
    private let accountUseCase: AccountUseCaseType
    private let signUpUseCase: SignUpUseCase
    
    // MARK: - initializer
    init(
        coordinator: SignUpCoordinatable,
        accountUseCase: AccountUseCaseType,
        signUpUseCase: SignUpUseCase
    ) {
        self.coordinator = coordinator
        self.accountUseCase = accountUseCase
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
                self.coordinator.toTermOfUse()
            }
        
        let isSignUpEnable = Driver.combineLatest(
            isAgeTermSelected,
            isPersonalInformationCollectionAndUsageSelected,
            isTermOfUse) {
                $0 && $1 && $2
            }
            .distinctUntilChanged()
            .startWith(false)
        
        let signedUp = input.tapSignUp.withLatestFrom(isMarketingConsent)
            .do { self.signUpUseCase.isMarketingConsent = $0 }
            .map { _ in self.signUpUseCase.signUpInformation }
            .do {
                if $0 == nil {
                    self.coordinator.showAlert(message: "정보를 모두 입력해주세요.", action: nil)
                }
            }
            .filter { $0 != nil }
            .compactMap { $0 }
            .flatMap {
                return self.accountUseCase.createAccount($0)
                    .asDriver(onErrorJustReturn: false)
            }
            .do { isSuccess in
                let message = isSuccess == true ? "회원가입 성공했습니다." : "회원가입 실패했습니다."
                self.coordinator.showAlert(message: message) {
                    if isSuccess {
                        self.coordinator.toLogin()
                    }
                }
            }
            .map { _ in }
        
        let signingUp = Driver.from([
            input.tapSignUp.map { _ in true },
            signedUp.map { _ in false }
        ])
            .merge()
            .distinctUntilChanged()
        
        return Output(
            isAllAgreeSelected: isAllAgreeSelected,
            isAgeTermSelected: isAgeTermSelected,
            isPersonalInformationCollectionAndUsageSelected: isPersonalInformationCollectionAndUsageSelected,
            isTermsOfUse: isTermOfUse,
            isMarketingConsent: isMarketingConsent,
            toPersonalInformationCollectionAndUsageDetail: toPersonalInformationCollectionAndUsageDetail,
            toTermsOfUseDetail: toTermsOfUseDetail,
            isSignUpEnable: isSignUpEnable,
            signingUp: signingUp,
            signedUp: signedUp
        )
    }
}
