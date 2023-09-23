//
//  SignUpCoordinator.swift
//  HeartHub
//
//  Created by 이태영 on 2023/09/23.
//

import UIKit

final class SignUpCoordinator {
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
}

// MARK: Public Interface
extension SignUpCoordinator: SignUpCoordinatable {
    func start() {
        
    }
}
