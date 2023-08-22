//
//  ProfileDoneReportViewController.swift
//  HeartHub
//
//  Created by 제민우 on 2023/08/20.
//

import UIKit

final class ProfileDoneReportViewController: UIViewController {

    
    let profileDoneReportView = ProfileDoneEditUserStatusView(mainText: "정상적으로 신고되었습니다.")
    
    override func loadView() {
        view = profileDoneReportView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureAddTarget()
    }
}

extension ProfileDoneReportViewController {
    private func configureAddTarget() {
        profileDoneReportView.profileDoneCloseButton.addTarget(
            self,
            action: #selector(didTapprofileDoneReportClosebutton),
            for: .touchUpInside
        )
    }

    @objc private func didTapprofileDoneReportClosebutton() {
        self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
        dismiss(animated: true)
    }
}
