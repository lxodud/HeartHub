//
//  MemberWithdrawalViewController.swift
//  HeartHub
//
//  Created by 전제윤 on 2023/08/19.
//

import UIKit

final class MemberWithdrawalViewController: UIViewController {
    
    private let memberWithdrawalView = MemberWithdrawalView()
    
    let unCheckedImage = UIImage(named: "AgreeRadioBtnUnChecked")
    let checkedImage = UIImage(named: "AgreeRadioBtnChecked")
    
    let unCheckBox = UIImage(named: "UnCheckBox")
    
    let checkBox = UIImage(named: "CheckBox")

  
    override func loadView() {
        view = memberWithdrawalView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addTarget()
        updateWithdrawalButtonState()
    }
    

    
    func addTarget() {
        memberWithdrawalView.allAgreebtn.addTarget(self, action: #selector(allAgreebtnTapped), for: .touchUpInside)
        memberWithdrawalView.reasonbtn1.addTarget(self, action: #selector(reasonbtn1Tapped), for: .touchUpInside)
        memberWithdrawalView.reasonbtn2.addTarget(self, action: #selector(reasonbtn2Tapped), for: .touchUpInside)
        memberWithdrawalView.reasonbtn3.addTarget(self, action: #selector(reasonbtn3Tapped), for: .touchUpInside)
        memberWithdrawalView.reasonbtn4.addTarget(self, action: #selector(reasonbtn4Tapped), for: .touchUpInside)
        memberWithdrawalView.memberWithdrawalBtn.addTarget(self, action: #selector(withdrawalButtonTapped), for: .touchUpInside)
    }
    
    private func updateWithdrawalButtonState() {
        let allAgreeSelected = memberWithdrawalView.allAgreebtn.currentImage == checkBox
        let atLeastOneReasonSelected = memberWithdrawalView.reasonbtn1.currentImage == checkedImage ||
                                       memberWithdrawalView.reasonbtn2.currentImage == checkedImage ||
                                       memberWithdrawalView.reasonbtn3.currentImage == checkedImage ||
                                       memberWithdrawalView.reasonbtn4.currentImage == checkedImage
        memberWithdrawalView.memberWithdrawalBtn.isEnabled = allAgreeSelected && atLeastOneReasonSelected
    }
    
    @objc func allAgreebtnTapped() {
        if memberWithdrawalView.allAgreebtn.currentImage == checkBox {
            memberWithdrawalView.allAgreebtn.setImage(unCheckBox, for: .normal)
        } else {
            memberWithdrawalView.allAgreebtn.setImage(checkBox, for: .normal)
        }
        updateWithdrawalButtonState() // 버튼 상태 업데이트
    }
    
    @objc func reasonbtn1Tapped() {
        if memberWithdrawalView.reasonbtn1.currentImage == checkedImage {
            memberWithdrawalView.reasonbtn1.setImage(unCheckedImage, for: .normal)
        } else {
            memberWithdrawalView.reasonbtn1.setImage(checkedImage, for: .normal)
        }
        updateWithdrawalButtonState() // 버튼 상태 업데이트
    }
    
    @objc func reasonbtn2Tapped() {
        if memberWithdrawalView.reasonbtn2.currentImage == checkedImage {
            memberWithdrawalView.reasonbtn2.setImage(unCheckedImage, for: .normal)
        } else {
            memberWithdrawalView.reasonbtn2.setImage(checkedImage, for: .normal)
        }
        updateWithdrawalButtonState() // 버튼 상태 업데이트
    }
    
    @objc func reasonbtn3Tapped() {
        if memberWithdrawalView.reasonbtn3.currentImage == checkedImage {
            memberWithdrawalView.reasonbtn3.setImage(unCheckedImage, for: .normal)
        } else {
            memberWithdrawalView.reasonbtn3.setImage(checkedImage, for: .normal)
        }
        updateWithdrawalButtonState() // 버튼 상태 업데이트
    }
    
    @objc func reasonbtn4Tapped() {
        if memberWithdrawalView.reasonbtn4.currentImage == checkedImage {
            memberWithdrawalView.reasonbtn4.setImage(unCheckedImage, for: .normal)
        } else {
            memberWithdrawalView.reasonbtn4.setImage(checkedImage, for: .normal)
        }
        updateWithdrawalButtonState() // 버튼 상태 업데이트
    }
    
    @objc func withdrawalButtonTapped() {
        let alertController = UIAlertController(title: "계정 삭제", message: "진짜 삭제하시겠습니까?", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        let confirmAction = UIAlertAction(title: "확인", style: .default) { [weak self] (_) in
            self?.performWithdrawal()
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(confirmAction)
        
        present(alertController, animated: true, completion: nil)
    }

    
    private func performWithdrawal() {
        // TODO: 실제 계정 삭제 로직 구현
        // ...
        navigationController?.popViewController(animated: true)
    }
    
    
}

