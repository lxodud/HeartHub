//
//  ProfileModifyViewModel.swift
//  HeartHub
//
//  Created by 이태영 on 2023/09/11.
//

import Foundation
import RxCocoa
import RxSwift

final class ProfileModifyViewModel: ViewModelType {
    struct Input {
        let newNickname: Driver<String>
        let viewWillAppear: Driver<Void>
    }
    
    struct Output {
        let profileImage: Driver<Data>
        let verifiedNewNickname: Driver<String>
        let initialNicknameAndImage: Driver<UserInformation>
    }
    
    private let myInformationUseCase: MyInformationUseCaseType
    private let pickedImage = PublishRelay<Data>()
    private let nickname = PublishRelay<String>()
    
    init(
        myInformationUseCase: MyInformationUseCaseType = MyInformationUseCase()
    ) {
        self.myInformationUseCase = myInformationUseCase
    }
}

// MARK: - Public Interface
extension ProfileModifyViewModel {
    func transform(_ input: Input) -> Output {
        let verifiedNewNickname = input.newNickname
            .scan("") { previous, new -> String in
                if self.validateNickname(new) {
                    return new
                } else {
                    return previous
                }
            }
            .map { $0.trimmingCharacters(in: .whitespaces) }
            .distinctUntilChanged()
        
        let fetchUserInformation = input.viewWillAppear
            .flatMapLatest {
                return self.myInformationUseCase.fetchMyInformation()
                    .asDriver(onErrorJustReturn: UserInformation(profileImage: Data(), nickname: "닉네임"))
            }

        return Output(
            profileImage: pickedImage.asDriver(onErrorJustReturn: Data()),
            verifiedNewNickname: verifiedNewNickname,
            initialNicknameAndImage: fetchUserInformation
        )
    }
}

// MARK: - Private Method
extension ProfileModifyViewModel {
    private func validateNickname(_ nickname: String) -> Bool {
        let maxLength = 10
        let allowedCharacterSet = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#$%^&*()-_?+=~")
            .union(CharacterSet(charactersIn: "\u{AC00}"..."\u{D7A3}"))
            .union(CharacterSet(charactersIn: "\u{3131}"..."\u{314E}"))
            .union(CharacterSet(charactersIn: "\u{314F}"..."\u{3163}"))
        
        if nickname.count <= maxLength {
            let characterSet = CharacterSet(charactersIn: nickname)
            return allowedCharacterSet.isSuperset(of: characterSet)
        } else {
            return false
        }
    }
}

// MARK: - HeartHubImagePickerDelegate Implementation
extension ProfileModifyViewModel: HeartHubImagePickerDelegate {
    func passSelectedImage(_ image: Data) {
        pickedImage.accept(image)
    }
}
