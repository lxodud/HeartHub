//
//  ConnectCheckPopUpViewController.swift
//  HeartHub
//
//  Created by 제민우 on 2023/08/15.
//

import UIKit

final class ConnectCheckPopUpViewController: UIViewController {

    private let connectCheckPopUpView = ConnectCheckPopUpView()
    
    override func loadView() {
        view = connectCheckPopUpView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureAddTarget()
    }
}

extension ConnectCheckPopUpViewController {
    private func configureAddTarget() {
        connectCheckPopUpView.connectPopUpCorrectButton.addTarget(self, action: #selector(didTapConnectPopUpCorrectButton), for: .touchUpInside)
        
        connectCheckPopUpView.connectPopUpReFindButton.addTarget(self, action: #selector(didTapConnectPopUpReFindButton), for: .touchUpInside)
    }
    
    @objc private func didTapConnectPopUpCorrectButton() {
        let connectCompletePopUpViewController = ConnectCompletePopUpViewController()
        connectCompletePopUpViewController.modalPresentationStyle = .fullScreen
        present(connectCompletePopUpViewController, animated: true)
    }
    
    @objc private func didTapConnectPopUpReFindButton() {
        dismiss(animated: true)
    }
}
