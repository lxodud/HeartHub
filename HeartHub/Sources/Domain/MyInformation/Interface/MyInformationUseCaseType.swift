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
}
