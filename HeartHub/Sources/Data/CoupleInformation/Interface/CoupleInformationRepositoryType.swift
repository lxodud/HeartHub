//
//  CoupleInformationRepositoryType.swift
//  HeartHub
//
//  Created by 이태영 on 2023/10/30.
//

import Foundation
import RxSwift

protocol CoupleInformationRepositoryType {
    func checkMateExist() -> Observable<Bool>
    func fetchMateInformation() -> Observable<UserInformation>
}

