//
//  WithdrawalViewModel.swift
//  HeartHub
//
//  Created by 이태영 on 2023/09/12.
//

import Foundation

final class WithdrawalViewModel {
    private let myInformationService: MyInformationService
    
    private var canWithdrawal: Bool = false {
        didSet {
            canWithdrawalHandler?(canWithdrawal)
        }
    }
    
    private var isCautionAgree: Bool = false {
        didSet {
            isCautionAgreeHandler?(canWithdrawal)
        }
    }
    
    var isCautionAgreeHandler: ((Bool) -> Void)?
    var canWithdrawalHandler: ((Bool) -> Void)?
    
    init(myInformationService: MyInformationService = MyInformationService()) {
        self.myInformationService = myInformationService
    }
}

// MARK: - Public Interface
extension WithdrawalViewModel {
    func agreeCaution() {
        canWithdrawal.toggle()
        isCautionAgree.toggle()
    }
    
    func withdraw(completion: @escaping (Bool) -> Void) {
        myInformationService.withdraw { isSuccess in
            completion(isSuccess)
        }
    }
}
