//
//  CoupleInformationUseCaseType.swift
//  HeartHub
//
//  Created by 이태영 on 2023/10/30.
//

import RxSwift

protocol CoupleInformationUseCaseType {
    func checkMateExist() -> Observable<Bool>
}
