//
//  ConnectCompletePopUpViewController.swift
//  HeartHub
//
//  Created by 제민우 on 2023/08/15.
//

import UIKit

class ConnectCompletePopUpViewController: UIViewController {

    private let connectCompletePopUpView = ConnectCompletePopUpView()
    
    override func loadView() {
        view = connectCompletePopUpView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureAddTarget()
    }
}

extension ConnectCompletePopUpViewController {
    private func configureAddTarget() {
        connectCompletePopUpView.connectCompleteCloseButton.addTarget(
            self,
            action: #selector(didTapconnectCompleteCloseButton),
            for: .touchUpInside)
        
    }
    
    @objc private func didTapconnectCompleteCloseButton() {
        dismiss(animated: true)
    }
}
