//
//  NetworkManagerType.swift
//  HeartHub
//
//  Created by 이태영 on 2023/09/20.
//

import Foundation
import RxSwift

protocol NetworkManagerType {
    @discardableResult
    func request<Builder: RequestBuilderProtocol>(
        _ builder: Builder
    ) -> Observable<Builder.Response>
}
