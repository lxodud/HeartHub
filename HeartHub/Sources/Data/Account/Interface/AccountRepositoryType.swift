//
//  AccountRepositoryType.swift
//  HeartHub
//
//  Created by 이태영 on 2023/09/22.
//

import Foundation
import RxSwift

protocol AccountRepositoryType {
    func modifyPassword(current: String, new: String) -> Completable
    func withdraw() -> Completable
    func findId(with email: String) -> Observable<Bool>
    func findPassword(id: String, email: String) -> Observable<Bool>
    func checkDuplicateId(_ id: String) -> Observable<Bool>
}
