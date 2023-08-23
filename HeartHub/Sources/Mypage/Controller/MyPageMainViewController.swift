//
//  MYPageMainViewController.swift
//  HeartHub
//
//  Created by 전제윤 on 2023/08/19.
//

import UIKit

final class MyPageMainViewController: UIViewController {
    
    private let myPageMainView = MyPageMainView()
    
    override func loadView() {
        view = myPageMainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAddTarget()
    }
    
    func setupAddTarget() {
        myPageMainView.profileResetBtn.addTarget(self, action: #selector(profileResetBtnTapped), for: .touchUpInside)
        myPageMainView.questionBtn.addTarget(self, action: #selector(questionBtnTapped), for: .touchUpInside)
        myPageMainView.alertSettingBtn.addTarget(self, action: #selector(alertSettingBtnTapped), for: .touchUpInside)
        myPageMainView.membershipWithdrawalBtn.addTarget(self, action: #selector(membershipWithdrawalBtnTapped), for: .touchUpInside)
        myPageMainView.pwdChangeBtn.addTarget(self, action: #selector(pwdChangeBtnTapped), for: .touchUpInside)
        myPageMainView.logOutBtn.addTarget(self, action: #selector(logOutBtnTapped), for: .touchUpInside)
        
    }
    


    
    @objc private func profileResetBtnTapped() {
        print("프로필 수정 화면으로 이동")
        let VC = ProfileResetViewController()
        self.navigationController?.pushViewController(VC, animated: true)
    }
    
    @objc private func questionBtnTapped() {
        print("1:1 문의 화면으로 이동")
        let VC = QuestionViewController()
        self.navigationController?.pushViewController(VC, animated: true)
    }
    
    @objc private func alertSettingBtnTapped() {
        print("알림 설정 화면으로 이동")
        let VC = AlertSettingViewController()
        let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
            backBarButtonItem.tintColor = .black  // 색상 변경
            self.navigationItem.backBarButtonItem = backBarButtonItem
        self.navigationController?.pushViewController(VC, animated: true)
    }
    
    @objc private func membershipWithdrawalBtnTapped() {
        print("회원 탈퇴 화면으로 이동")
        let VC = MemberWithdrawalViewController()
        self.navigationController?.pushViewController(VC, animated: true)
    }
    
    @objc private func pwdChangeBtnTapped() {
        print("비밀번호 변경 화면으로 이동")
        let VC = PasswordChangeViewController()
        self.navigationController?.pushViewController(VC, animated: true)
    }
    
    @objc private func logOutBtnTapped() {
        print("로그아웃 화면으로 이동")
        let myPageLogoutAlertViewController = MyPageLogoutAlertViewController()
        modalPresentationStyle = .fullScreen
        present(myPageLogoutAlertViewController, animated: true)
    }
    
    func updateProfileImage(image: UIImage) {
        
        myPageMainView.updateProfileImage(image)
    }
    
    func updateProfileNickname(nickname: String) {
        myPageMainView.profileNickname.text = nickname
    }

    
}

