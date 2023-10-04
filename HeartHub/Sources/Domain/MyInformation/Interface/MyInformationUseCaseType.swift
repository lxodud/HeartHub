//
//  MyInformationUseCaseType.swift
//  HeartHub
//
//  Created by 이태영 on 2023/09/21.
//

import Foundation
import RxSwift

protocol MyInformationUseCaseType {
    func editMyInformation(imageData: Data, nickname: String) -> Completable
    func fetchMyInformation() -> Observable<UserInformation>
    func verifyNickname(_ nickname: String) -> Bool
    func checkDuplicationNickname(_ nickname: String) -> Observable<Bool>
}
