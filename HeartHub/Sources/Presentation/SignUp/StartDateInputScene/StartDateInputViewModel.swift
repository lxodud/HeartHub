//
//  StartDateInputViewModel.swift
//  HeartHub
//
//  Created by 이태영 on 2023/09/24.
//

import Foundation
import RxCocoa
import RxSwift

final class StartDateInputViewModel: ViewModelType {
    struct Input {
        let date: Observable<Date>
    }
    
    struct Output {
        let formattedDate: Driver<String>
        let isNextEnable: Driver<Bool>
    }
}

// MARK: - Public Interface
extension StartDateInputViewModel {
    func transform(_ input: Input) -> Output {
        let formattedDate = input.date
            .map { SignUpDateFormatter.shared.string(from: $0) }
            .asDriver(onErrorJustReturn: "")
        
        let isNextEnable = input.date
            .map{ _ in true }
            .startWith(false)
            .distinctUntilChanged()
            .asDriver(onErrorJustReturn: false)
        
        return Output(
            formattedDate: formattedDate,
            isNextEnable: isNextEnable
        )
    }
}

final class SignUpDateFormatter {
    static let shared = SignUpDateFormatter()
    
    private init() { }
    
    private let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy년 MM월 dd일"
        return dateFormatter
    }()
    
    func string(from: Date) -> String {
        return dateFormatter.string(from: from)
    }
}
