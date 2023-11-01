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
    }
    
}

// MARK: - Public Interface
extension MyPageMainViewModel {
    func transform(_ input: Input) -> Output {
        let menu = Driver.of(MyPageRow.allCases)
        
        return Output(
            menu: menu
        )
    }
}

// MARK: Private Method
extension MyPageMainViewModel {
    private func presentation(to indexPath: IndexPath) {
        guard let row = MyPageRow(rawValue: indexPath.row) else {
            return
        }
        
        switch row {
        case .editProfile:
            break
        case .inquiry:
            break
        case .withdrawal:
            break
        case .changePassword:
            break
        case .logout:
            break
        }
    }
}

enum MyPageRow: Int, CaseIterable {
    case editProfile = 0
    case inquiry
    case withdrawal
    case changePassword
    case logout
    
    var title: String {
        switch self {
        case .editProfile:
            return "프로필 수정"
        case .inquiry:
            return "1:1 문의"
        case .withdrawal:
            return "회원탈퇴"
        case .changePassword:
            return "비밀번호 변경"
        case .logout:
            return "로그아웃"
        }
    }
}
