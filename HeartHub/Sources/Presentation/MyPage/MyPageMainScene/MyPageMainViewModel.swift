//
//  MyPageMainViewModel.swift
//  HeartHub
//
//  Created by 이태영 on 2023/11/01.
//

import Foundation
import RxCocoa
import RxSwift

final class MyPageMainViewModel: ViewModelType {
    struct Input {
        let cellSelected: Driver<IndexPath>
    }
    
    struct Output {
        let menu: Driver<[MyPageRow]>
        let toNext: Driver<Void>
    }
    
    private let coordinator: MyPageCoordinatable
    
    init(coordinator: MyPageCoordinatable) {
        self.coordinator = coordinator
    }
}

// MARK: - Public Interface
extension MyPageMainViewModel {
    func transform(_ input: Input) -> Output {
        let menu = Driver.of(MyPageRow.allCases)
        let toNext = input.cellSelected
            .do { self.presentation(to: $0) }
            .map { _ in }
        
        return Output(
            menu: menu,
            toNext: toNext
        )
    }
}

// MARK: Private Method
extension MyPageMainViewModel {
    private func presentation(to indexPath: IndexPath) {
        guard let page = MyPageRow(rawValue: indexPath.row) else {
            return
        }
        
        switch page {
        case .editProfile:
            coordinator.toEditProfile()
        case .withdrawal:
            coordinator.toWithdrawal()
        case .changePassword:
            coordinator.toChangePassword()
        case .logout:
            coordinator.showAlert(message: "로그아웃 하시겠습니까?") {
                self.coordinator.toLogin()
            }
        }
    }
}

enum MyPageRow: Int, CaseIterable {
    case editProfile = 0
    case withdrawal
    case changePassword
    case logout
    
    var title: String {
        switch self {
        case .editProfile:
            return "프로필 수정"
        case .withdrawal:
            return "회원탈퇴"
        case .changePassword:
            return "비밀번호 변경"
        case .logout:
            return "로그아웃"
        }
    }
}
