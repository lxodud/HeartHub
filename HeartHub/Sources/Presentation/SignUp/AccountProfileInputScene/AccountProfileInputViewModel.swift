//
//  AccountProfileInputViewModel.swift
//  HeartHub
//
//  Created by 이태영 on 2023/09/25.
//

import Foundation
import RxCocoa
import RxSwift

final class AccountProfileInputViewModel: ViewModelType {
    struct Input {
        let id: Driver<String>
        let tapCheckIdDuplication: Driver<Void>
        let password: Driver<String>
        let tapPasswordSecure: Driver<Void>
        let tapMale: Driver<Void>
        let tapFemale: Driver<Void>
        let birth: Observable<Date>
        let tapNext: Driver<Void>
    }
    
    struct Output {
        let verifiedId: Driver<String>
        let checkingDuplicationId: Driver<Bool>
        let idDescription: Driver<String>
        let idDescriptionColor: Driver<SignUpColor>
        let verifiedPassword: Driver<String>
        let isPasswordSecure: Driver<Bool>
        let formattedBirth: Driver<String>
        let isMale: Driver<Bool>
        let isFemale: Driver<Bool>
        let isNextEnable: Driver<Bool>
        let toNext: Driver<Void>
    }
    
    private let coordinator: SignUpCoordinatable
    private let accountUseCase: AccountUseCaseType
    private let signUpUseCase: SignUpUseCaseType
    
    init(
        coordinator: SignUpCoordinatable,
        accountUseCase: AccountUseCaseType,
        signUpUseCase: SignUpUseCaseType
    ) {
        self.coordinator = coordinator
        self.accountUseCase = accountUseCase
        self.signUpUseCase = signUpUseCase
    }
}

// MARK: - Public Interface
extension AccountProfileInputViewModel {
    func transform(_ input: Input) -> Output {
        let verifiedId = input.id
            .distinctUntilChanged()
            .scan("") { (previous, new) in
                return self.accountUseCase.verifyId(new) ? new : previous
            }
        
        let isDuplicatedId = input.tapCheckIdDuplication.withLatestFrom(verifiedId)
            .flatMap { id in
                return self.accountUseCase.checkDuplicationId(id)
                    .asDriver(onErrorJustReturn: false)
            }
        
        let checkingDuplicationId = Driver.from([
            input.tapCheckIdDuplication.map { _ in true },
            isDuplicatedId.map { _ in false }
        ])
            .merge()
            .distinctUntilChanged()
        
        let idDescription = Driver.from([
            isDuplicatedId.map { $0 == true ? "사용 가능한 아이디입니다." : "중복된 아이디입니다." },
            verifiedId.map { _ in "영문/숫자 구성" }
        ])
            .merge()
            .distinctUntilChanged()
        
        let idDescriptionColor = Driver.from([
            isDuplicatedId.map { $0 == true ? SignUpColor.green : SignUpColor.red },
            verifiedId.map { _ in SignUpColor.gray }
        ])
            .merge()
            .distinctUntilChanged()
        
        let verifiedPassword = input.password
            .scan("") { (previous, new) in
                return self.accountUseCase.verifyPassword(new) ? new : previous
            }
        
        let isPasswordSecure = input.tapPasswordSecure
            .scan(true) { state, _ in
                return !state
            }

        let formattedBirth = input.birth
            .map { SignUpDateFormatter.shared.string(from: $0) }
            .asDriver(onErrorJustReturn: "")
        
        let isMale = Driver.from([
            input.tapMale.map { _ in true },
            input.tapFemale.map { _ in false }
        ])
            .merge()
            .startWith(true)
            .distinctUntilChanged()
        
        let isFemale = Driver.from([
            input.tapMale.map { _ in false },
            input.tapFemale.map { _ in true }
        ])
            .merge()
            .startWith(false)
            .distinctUntilChanged()
        
        let isIdConfirm = Driver.from([
            verifiedId.map { _ in false },
            isDuplicatedId
        ])
            .merge()
            .distinctUntilChanged()

        let isNextEnable = Driver.combineLatest(
            isIdConfirm,
            verifiedPassword,
            formattedBirth
        ) {
            $0 && !$1.isEmpty && !$2.isEmpty
        }
            .startWith(false)
            .debug()
        
        let idPasswordGenderBirth = Driver.combineLatest(
            verifiedId,
            verifiedPassword,
            isFemale,
            input.birth.asDriver(onErrorJustReturn: Date())
        ) {
            (id: $0, password: $1, gender: $2, birth: $3)
        }
        
        let toNext = input.tapNext.withLatestFrom(idPasswordGenderBirth)
            .do { self.signUpUseCase.upsertId($0.id) }
            .do { self.signUpUseCase.upsertPassword($0.password) }
            .do { self.signUpUseCase.upsertGender($0.gender == true ? .female : .male) }
            .do { self.signUpUseCase.upsertBirth($0.birth) }
            .do { _ in self.coordinator.toNicknameEmailInput() }
            .map { _ in }
        
        return Output(
            verifiedId: verifiedId,
            checkingDuplicationId: checkingDuplicationId,
            idDescription: idDescription,
            idDescriptionColor: idDescriptionColor,
            verifiedPassword: verifiedPassword,
            isPasswordSecure: isPasswordSecure,
            formattedBirth: formattedBirth,
            isMale: isMale,
            isFemale: isFemale,
            isNextEnable: isNextEnable,
            toNext: toNext
        )
    }
}
