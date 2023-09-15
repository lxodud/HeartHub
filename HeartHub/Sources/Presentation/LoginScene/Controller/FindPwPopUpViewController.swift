//
//  FindPwPopUpViewController.swift
//  HeartHub
//
//  Created by 제민우 on 2023/07/24.
//

import UIKit

final class FindPwPopUpViewController: UIViewController {


    private let findPwPopUpView = FindPwPopUpView()
    
    override func loadView() {
        view = findPwPopUpView
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setupAddTarget()
    }
    
    func setupAddTarget() {
        findPwPopUpView.closeBtn.addTarget(self, action: #selector(didTapCloseBtn), for: .touchUpInside)
    }

    @objc private func didTapCloseBtn() {
        dismiss(animated: true)
    }
}
