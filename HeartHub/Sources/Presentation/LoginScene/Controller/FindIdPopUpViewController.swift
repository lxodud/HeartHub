//
//  heartHubModalViewController.swift
//  HeartHub
//
//  Created by 제민우 on 2023/07/16.
//

import UIKit

final class FindIdPopUpViewController: UIViewController {
    
//    let screenHeight = UIScreen.main.bounds.size.height
//    let screenWidth = UIScreen.main.bounds.size.width

    private let findIdPopUpView = FindIdPopUpView()
    
    override func loadView() {
        view = findIdPopUpView
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setupAddTarget()
    }
    
    func setupAddTarget() {
        findIdPopUpView.closeBtn.addTarget(self, action: #selector(didTapCloseBtn), for: .touchUpInside)
    }

    @objc private func didTapCloseBtn() {
        dismiss(animated: true)
    }
}
