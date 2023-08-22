//
//  File.swift
//  HeartHub
//
//  Created by 제민우 on 2023/08/23.
//

import UIKit

final class ReportActionSheet {
    
    private var blockStatus: Bool = true
    
    @objc private func configureReportAlert(vc: UIViewController) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let report = UIAlertAction(title: "게시물 신고하기", style: .default) { [weak self] (action) in
            self?.presentReportUserViewController(vc: vc)
        }
        let block = UIAlertAction(title: "이 게시물의 작성자 차단하기", style: .default) { [weak self] (action) in
            self?.presentBlockUserViewController(vc: vc)
        }
        let cancelBlock = UIAlertAction(title: "차단 해제", style: .default) { [weak self] (action) in
            self?.presentCancelBlockUserViewController(vc: vc)
        }

        let cancel = UIAlertAction(title: "취소", style: .cancel)
                
        alert.addAction(report)
        if blockStatus == true {
            alert.addAction(cancelBlock)
        } else {
            alert.addAction(block)
        }
        alert.addAction(cancel)
                
        vc.present(alert, animated: true, completion: nil)
    }
    
    private func presentReportUserViewController(vc: UIViewController) {
        let reportUserViewController = ProfileReportReasonViewController()
        vc.modalPresentationStyle = .overFullScreen
        vc.present(reportUserViewController, animated: true)
    }
    
    private func presentBlockUserViewController(vc: UIViewController) {
        let blockUserViewController = ProfileBlockUserViewController()
        vc.modalPresentationStyle = .overFullScreen
        vc.present(blockUserViewController, animated: true)
    }
    
    private func presentCancelBlockUserViewController(vc: UIViewController) {
        let profileBlockCancelViewController = ProfileBlockCancelViewController()
        vc.modalPresentationStyle = .overFullScreen
        vc.present(profileBlockCancelViewController, animated: true)
    }
}
