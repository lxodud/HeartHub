//
//  AuthenticationRepositoryType.swift
//  HeartHub
//
//  Created by 이태영 on 2023/09/20.
//

import Foundation
import RxSwift

protocol AuthenticationRepositoryType {
    func login(id: String, password: String) -> Observable<Bool>
    func logout() -> Completable
}
