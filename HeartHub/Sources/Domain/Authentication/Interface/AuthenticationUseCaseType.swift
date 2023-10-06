//
//  AuthenticationUseCaseType.swift
//  HeartHub
//
//  Created by 이태영 on 2023/09/20.
//

import RxSwift

protocol AuthenticationUseCaseType {
    func login(id: String, password: String) -> Observable<Bool>
    func logout() -> Completable
    func sendVerificationCode(to email: String) -> Observable<Bool>
    func checkVerificationCode(with code: String) -> Bool
}
