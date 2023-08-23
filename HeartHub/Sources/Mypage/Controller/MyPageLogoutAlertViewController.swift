//
//  MyPageLogoutAlertViewController.swift
//  HeartHub
//
//  Created by 제민우 on 2023/08/23.
//

import UIKit

class MyPageLogoutAlertViewController: UIViewController {

    private let myPageLogoutAlertView = MyPageLogoutAlertView()
    
    override func loadView() {
        view = myPageLogoutAlertView
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        configureAddTarget()
    }
    
    private func configureAddTarget() {
        myPageLogoutAlertView.logoutCancelButton.addTarget(self, action: #selector(didTapCancelButton), for: .touchUpInside)
        myPageLogoutAlertView.logoutVerifyButton.addTarget(self, action: #selector(didTapVerifyButton), for: .touchUpInside)
    }

    @objc private func didTapCancelButton() {
        dismiss(animated: true)
    }
    
    @objc private func didTapVerifyButton() {
        dismiss(animated: true)
    }
}
