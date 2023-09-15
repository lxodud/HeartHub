//
//  FindPwViewController.swift
//  HeartHub
//
//  Created by 제민우 on 2023/07/24.
//

import UIKit

final class FindPwViewController: UIViewController {

    private let findPwView = FindPwView()
    
    override func loadView() {
        view = findPwView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAddTarget()
        
    }
    
    func setupAddTarget() {
        findPwView.findIdBtn.addTarget(self, action: #selector(didTapFindIdButton), for: .touchUpInside)
        findPwView.signUpBtn.addTarget(self, action: #selector(didTapSignUpButton), for: .touchUpInside)
        findPwView.findPwButton.addTarget(self, action: #selector(didTapFindPwButton), for: .touchUpInside)
        findPwView.loginBtn.addTarget(self, action: #selector(didTaploginBtn), for: .touchUpInside)

    }

    @objc private func didTaploginBtn() {
        navigationController?.popToRootViewController(animated: true)
    }
    
    @objc private func didTapFindIdButton() {
        let findIdVC = FindIdViewController()
        navigationController?.pushViewController(findIdVC, animated: true)
    }
    
    @objc private func didTapSignUpButton() {
        let signUpVC = SignUpStartDateViewController()
        navigationController?.pushViewController(signUpVC, animated: true)
    }
    
    @objc private func didTapFindPwButton() {

        let idPattern = #"^[a-zA-Z0-9+-\_.]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$"#
        let isVaildPattern = (findPwView.enterEmailTextField.text!.range(of: idPattern, options: .regularExpression) != nil)
        if isVaildPattern {
            let findPwPopUpVC = FindPwPopUpViewController()
            findPwPopUpVC.modalPresentationStyle = .overFullScreen
            present(findPwPopUpVC, animated: true, completion: nil)
        } else {
            print("올바른 이메일 형식 x")
        }
    }
    
    
    
}
