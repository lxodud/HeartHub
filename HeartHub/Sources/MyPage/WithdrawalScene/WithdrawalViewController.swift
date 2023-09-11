//
//  WithdrawalViewController.swift
//  HeartHub
//
//  Created by 이태영 on 2023/09/11.
//

import UIKit

final class WithdrawalViewController: UIViewController {
    private let noticeLabel: UILabel = {
        let label = UILabel()
        label.text = "잠깐! 탈퇴 전, 아래의 사항을\n꼭 확인해주세요."
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = UIColor(red: 0.6, green: 0.6, blue: 0.6, alpha: 1)
        label.font = UIFont(name: "Pretendard-SemiBold", size: 16)
        return label
    }()
    
    private let agreeCheckBoxRectangle: UIView = {
        let view = UIView()
        view.layer.borderColor = UIColor.systemGray4.cgColor
        view.layer.borderWidth = 1
        view.clipsToBounds = true
        view.layer.cornerRadius = 20
        return view
    }()
    
    private let agreeNoticeLabel: UILabel = {
        let text = "탈퇴 시 모든 데이터가 사라지며, 복구 불가합니다."
        let attributedString = NSMutableAttributedString(string: text)
        let range = (text as NSString).range(of: "복구 불가")
        let color = UIColor(red: 0.98, green: 0.184, blue: 0.741, alpha: 1)
        attributedString.addAttribute(.foregroundColor, value: color, range: range)
        let label = UILabel()
        label.attributedText = attributedString
        label.font = UIFont(name: "Pretendard-SemiBold", size: 16)
        return label
    }()
    
    private let agreeCheckBox: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "withdrawalAgreeCheckoutBoxEnabled"), for: .selected)
        button.setImage(UIImage(named: "withdrawalAgreeCheckoutBoxDisabled"), for: .normal)
        return button
    }()
    
    private let agreeCheckBoxDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "안내사항을 모두 확인하였으며 이에 동의합니다."
        label.textColor = UIColor(red: 0.463, green: 0.463, blue: 0.463, alpha: 1)
        label.font = UIFont(name: "Pretendard-Regular", size: 14)
        return label
    }()
    
    private let reasonNoticeLabel: UILabel = {
        let text = "탈퇴 사유 (복수 선택 가능)"
        let attributedString = NSMutableAttributedString(string: text)
        let frontRange = (text as NSString).range(of: "탈퇴 사유")
        let backRange = (text as NSString).range(of: "(복수 선택 가능)")
        let boldFont = UIFont(name: "Pretendard-SemiBold", size: 16) ?? UIFont()
        let regularFont = UIFont(name: "Pretendard-Regular", size: 14) ?? UIFont()
        attributedString.addAttribute(.font, value: boldFont, range: frontRange)
        attributedString.addAttribute(.font, value: regularFont, range: backRange)
        let label = UILabel()
        label.attributedText = attributedString
        return label
    }()
    
    private let reasonCheckBoxes: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            WithdrawalReasonCheckBoxStackView(description: "애인과 헤어지게 됐습니다."),
            WithdrawalReasonCheckBoxStackView(description: "본 앱에 더 이상 흥미가 없습니다."),
            WithdrawalReasonCheckBoxStackView(description: "기술적인 문제 및 버그가 발생하였습니다."),
            WithdrawalReasonCheckBoxStackView(description: "기타")
        ])
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 20
        return stackView
    }()
    
    private let withdrawalButton: UIButton = {
        let button = UIButton()
        button.setTitle("계정 삭제", for: .normal)
        button.backgroundColor = .systemGray4
        button.titleLabel?.font = UIFont(name: "Pretendard-SemiBold", size: 16)
        button.layer.cornerRadius = 20
        return button
    }()
    
    override func viewDidLoad() {
        configureSubview()
        configureLayout()
        configureNavigationBar()
    }
}

// MARK: - Configure UI
extension WithdrawalViewController {
    private func configureSubview() {
        [noticeLabel, agreeCheckBoxRectangle, reasonNoticeLabel, reasonCheckBoxes, withdrawalButton].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        [agreeNoticeLabel, agreeCheckBox, agreeCheckBoxDescriptionLabel].forEach {
            agreeCheckBoxRectangle.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        view.backgroundColor = .systemBackground
    }
    
    private func configureLayout() {
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            // MARK: - noticeLabel Constraints
            noticeLabel.topAnchor.constraint(
                equalTo: safeArea.topAnchor,
                constant: 26
            ),
            noticeLabel.centerXAnchor.constraint(
                equalTo: safeArea.centerXAnchor
            ),
            
            // MARK: - agreeCheckBoxRectangle Constraints
            agreeCheckBoxRectangle.topAnchor.constraint(
                equalTo: noticeLabel.bottomAnchor,
                constant: 26
            ),
            agreeCheckBoxRectangle.widthAnchor.constraint(
                equalTo: safeArea.widthAnchor,
                multiplier: 0.9
            ),
            agreeCheckBoxRectangle.heightAnchor.constraint(
                equalTo: safeArea.heightAnchor,
                multiplier: 0.25
            ),
            agreeCheckBoxRectangle.centerXAnchor.constraint(
                equalTo: safeArea.centerXAnchor
            ),
            
            // MARK: - agreeNoticeLabel Constraints
            agreeNoticeLabel.centerXAnchor.constraint(
                equalTo: agreeCheckBoxRectangle.centerXAnchor
            ),
            agreeNoticeLabel.centerYAnchor.constraint(
                equalTo: agreeCheckBoxRectangle.centerYAnchor,
                constant: -20
            ),
            
            // MARK: - agreeCheckBox Constraints
            agreeCheckBox.leadingAnchor.constraint(
                equalTo: agreeNoticeLabel.leadingAnchor
            ),
            agreeCheckBox.centerYAnchor.constraint(
                equalTo: agreeCheckBoxRectangle.centerYAnchor,
                constant: 25
            ),
            
            // MARK: - agreeCheckBoxDescriptionLabel Constraints
            agreeCheckBoxDescriptionLabel.leadingAnchor.constraint(
                equalTo: agreeCheckBox.trailingAnchor,
                constant: 8
            ),
            agreeCheckBoxDescriptionLabel.centerYAnchor.constraint(
                equalTo: agreeCheckBox.centerYAnchor
            ),
            
            // MARK: reasonNoticeLabel Constraints
            reasonNoticeLabel.topAnchor.constraint(
                equalTo: agreeCheckBoxRectangle.bottomAnchor,
                constant: 26
            ),
            reasonNoticeLabel.leadingAnchor.constraint(
                equalTo: agreeCheckBoxRectangle.leadingAnchor
            ),
            
            // MARK: - reasonCheckBoxes Constraints
            reasonCheckBoxes.topAnchor.constraint(
                equalTo: reasonNoticeLabel.bottomAnchor,
                constant: 20
            ),
            reasonCheckBoxes.centerXAnchor.constraint(
                equalTo: safeArea.centerXAnchor
            ),
            reasonCheckBoxes.widthAnchor.constraint(
                equalTo: safeArea.widthAnchor,
                multiplier: 0.75
            ),
            
            // MARK: - withdrawalButton Constraints
            withdrawalButton.bottomAnchor.constraint(
                equalTo: safeArea.bottomAnchor,
                constant: -26
            ),
            withdrawalButton.centerXAnchor.constraint(
                equalTo: safeArea.centerXAnchor
            ),
            withdrawalButton.widthAnchor.constraint(
                equalTo: safeArea.widthAnchor,
                multiplier: 0.85
            ),
            withdrawalButton.heightAnchor.constraint(
                equalToConstant: 60
            ),
        ])
    }
    
    private func configureNavigationBar() {
        navigationItem.title = "회원 탈퇴"
    }
}
