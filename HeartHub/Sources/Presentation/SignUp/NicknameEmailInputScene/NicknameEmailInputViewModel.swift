//
//  NicknameEmailInputViewModel.swift
//  HeartHub
//
//  Created by 이태영 on 2023/10/03.
//

import RxCocoa
import RxSwift

final class NicknameEmailInputViewModel: ViewModelType {
    struct Input {
        let nickname: Driver<String>
        let tapCheckNicknameDuplication: Driver<Void>
    }
    
    struct Output {
        let verifiedNickname: Driver<String>
        let checkingDuplicationNickname: Driver<Bool>
        let isCheckNicknameDuplicationEnable: Driver<Bool>
        let nicknameDescription: Driver<String>
        let nicknameDescriptionColor: Driver<SignUpColor>
    }
    
    private let myInformationUseCase: MyInformationUseCaseType
    
    init(
        myInformationUseCase: MyInformationUseCaseType
    ) {
        self.myInformationUseCase = myInformationUseCase
    }
}

// MARK: Public Interface
extension NicknameEmailInputViewModel {
    func transform(_ input: Input) -> Output {
        let verifiedNickname = input.nickname
            .distinctUntilChanged()
            .scan("") { (previous, new) in
                return self.myInformationUseCase.verifyNickname(new) ? new : previous
            }
        
        let isDuplicatedNickname = input.tapCheckNicknameDuplication.withLatestFrom(verifiedNickname)
            .flatMap { nickname in
                return self.myInformationUseCase.checkDuplicationNickname(nickname)
                    .asDriver(onErrorJustReturn: false)
            }
        
        let checkingDuplicationNickname = Driver.from([
            input.tapCheckNicknameDuplication.map { _ in true },
            isDuplicatedNickname.map { _ in false }
        ])
            .merge()
            .distinctUntilChanged()
        
        let isCheckNicknameDuplicationEnable = Driver.from([
            verifiedNickname.map { !$0.isEmpty },
            checkingDuplicationNickname.map { !$0 }
        ])
            .merge()
            .distinctUntilChanged()
        
        let nicknameDescription = Driver.from([
            isDuplicatedNickname.map { $0 == true ? "사용 가능한 닉네임입니다." : "중복된 닉네임입니다." },
            verifiedNickname.map { _ in "영문/숫자 구성" }
        ])
            .merge()
            .distinctUntilChanged()
        
        let nicknameDescriptionColor = Driver.from([
            isDuplicatedNickname.map { $0 == true ? SignUpColor.green : SignUpColor.red },
            verifiedNickname.map { _ in SignUpColor.gray }
        ])
            .merge()
            .distinctUntilChanged()
        
        return Output(
            verifiedNickname: verifiedNickname,
            checkingDuplicationNickname: checkingDuplicationNickname,
            isCheckNicknameDuplicationEnable: isCheckNicknameDuplicationEnable,
            nicknameDescription: nicknameDescription,
            nicknameDescriptionColor: nicknameDescriptionColor
        )
    }
}
