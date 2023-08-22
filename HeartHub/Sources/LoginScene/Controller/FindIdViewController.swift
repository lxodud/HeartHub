//
//  FindIdViewController.swift
//  HeartHub
//
//  Created by 제민우 on 2023/07/16.
//

import UIKit

final class FindIdViewController: UIViewController {

    private let findIdView = FindIdView()
    
    override func loadView() {
        view = findIdView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAddTarget()
        
    }
    
    func setupAddTarget() {
        findIdView.findIdButton.addTarget(self, action: #selector(didTapFindIdButton), for: .touchUpInside)
        findIdView.signUpBtn.addTarget(self, action: #selector(didTapSignUpButton), for: .touchUpInside)
        findIdView.findPwBtn.addTarget(self, action: #selector(didTapFindPwButton), for: .touchUpInside)
        findIdView.loginBtn.addTarget(self, action: #selector(didTaploginBtn), for: .touchUpInside)
    }

    @objc private func didTaploginBtn() {
        navigationController?.popToRootViewController(animated: true)
    }
    
    @objc private func didTapFindIdButton() {
        
        let idPattern = #"^[a-zA-Z0-9+-\_.]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$"#
        let isVaildPattern = (findIdView.enterEmailTextField.text!.range(of: idPattern, options: .regularExpression) != nil)
        if isVaildPattern {
            let findIdPopUpVC = FindIdPopUpViewController()
            findIdPopUpVC.modalPresentationStyle = .overFullScreen
            present(findIdPopUpVC, animated: true, completion: nil)
        } else {
            print("올바른 이메일 형식 x")
        }
    }
    
    @objc private func didTapSignUpButton() {
        let signUpVC = SignUpStartDateViewController()
        
        navigationController?.pushViewController(signUpVC, animated: true)
    }
    
    @objc private func didTapFindPwButton() {
         let findPwVC = FindPwViewController()
        
        navigationController?.pushViewController(findPwVC, animated: true)
    }
}
