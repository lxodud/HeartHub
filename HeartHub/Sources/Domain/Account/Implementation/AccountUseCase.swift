//
//  AccountUseCase.swift
//  HeartHub
//
//  Created by 이태영 on 2023/09/22.
//

import Foundation
import RxSwift

final class AccountUseCase {
    private let accountRepository: AccountRepositoryType
    private let myInformationRepository: MyInformationRepositoryType
    
    init(
        accountRepository: AccountRepositoryType = AccountRepository(),
        myInformationRepository: MyInformationRepositoryType = MyInformationRepository()
    ) {
        self.accountRepository = accountRepository
        self.myInformationRepository = myInformationRepository
    }
}

// MARK: - Public Interface
extension AccountUseCase: AccountUseCaseType {
    func modifyPassword(current: String, new: String ) -> Completable {
        return accountRepository.modifyPassword(current: current, new: new)
    }
    
    func withdraw() -> Completable {
        myInformationRepository.removeMyInformation()
        return accountRepository.withdraw()
    }
    
    func findId(with email: String) -> Observable<Bool> {
        return accountRepository.findId(with: email)
    }
    
    func findPassword(id: String, email: String) -> Observable<Bool> {
        return accountRepository.findPassword(id: id, email: email)
    }
    
    func checkDuplicationId(_ id: String) -> Observable<Bool> {
        return accountRepository.checkDuplicationId(id)
    }
    
    func verifyId(_ id: String) -> Bool {
        let maxLength = 18
        let allowedCharacterSet = CharacterSet(
            charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        )
        
        guard id.count <= maxLength else {
            return false
        }
        
        return allowedCharacterSet.isSuperset(of: CharacterSet(charactersIn: id))
    }
    
    func verifyPassword(_ password: String) -> Bool {
        let maxLength = 15
        let allowedCharacterSet = CharacterSet(
            charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#$%^&*()-_?+=~,./[]{}<>"
        )
        
        guard password.count <= maxLength else {
            return false
        }
        return allowedCharacterSet.isSuperset(of: CharacterSet(charactersIn: password))
    }
    
    func verifyEmailFormat(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
        return  NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: email)
    }
    
    func createAccount(_ signUpInformation: SignUpInformation) -> Observable<Bool> {
        return accountRepository.createAccount(signUpInformation)
    }
}
