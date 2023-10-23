//
//  AccountUseCaseType.swift
//  HeartHub
//
//  Created by 이태영 on 2023/09/22.
//

import Foundation
import RxSwift

protocol AccountUseCaseType {
    func modifyPassword(current: String, new: String ) -> Completable
    func withdraw() -> Completable
    func findId(with email: String) -> Observable<Bool>
    func findPassword(id: String, email: String) -> Observable<Bool>
    func verifyId(_ id: String) -> Bool
    func verifyPassword(_ password: String) -> Bool
    func checkDuplicationId(_ id: String) -> Observable<Bool>
    func verifyEmailFormat(_ email: String) -> Bool
    func createAccount(_ signUpInformation: SignUpInformation) -> Observable<Bool>
}
