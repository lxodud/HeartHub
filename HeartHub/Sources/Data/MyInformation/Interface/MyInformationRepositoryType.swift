//
//  MyInformationRepositoryType.swift
//  HeartHub
//
//  Created by 이태영 on 2023/09/20.
//

import Foundation
import RxSwift

protocol MyInformationRepositoryType {
    func upsertUserInformation(with userInformation: UserInformation) -> Completable
    func fetchUserInformation() -> Observable<UserInformation>
    func removeMyInformation()
    func checkDuplicationNickname(_ nickname: String) -> Observable<Bool>
}
