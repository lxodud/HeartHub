//
//  MyPageDoneProfileSetView.swift
//  HeartHub
//
//  Created by 제민우 on 2023/08/22.
//

import UIKit

final class MyPageDoneProfileSetView: UIView {
    
    private var doneProfileUpdateLabel: UILabel = {
        let label = UILabel()
        label.text = "프로필 수정 완료!"
        label.numberOfLines = 2
        label.textAlignment = .center
        label.font = UIFont(name: "Pretendard-SemiBold", size: 24)
        label.adjustsFontForContentSizeCategory = true
        label.textColor = .black
        return label
    }()
    
    var doneProfileUpdateButton = AlertButton(buttonColor: .white, borderColor: #colorLiteral(red: 0.9803773761, green: 0.1853338182, blue: 0.7394250631, alpha: 1), title: "확인", titleColor: .black)
    
    private var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.clipsToBounds = true
        view.layer.cornerRadius = 18
        return view
    }()
    
    // MARK: 뷰 초기화
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(red: 0.067, green: 0.067, blue: 0.067, alpha: 0.2)
        configureSubviews()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MyPageDoneProfileSetView {

    // MARK: 제약
    private func configureSubviews() {
        [doneProfileUpdateLabel, doneProfileUpdateButton].forEach {
            containerView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
    }

    private func configureConstraints() {
        
        let safeArea = safeAreaLayoutGuide

        NSLayoutConstraint.activate([
            containerView.centerXAnchor.constraint(equalTo: centerXAnchor),
            containerView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 244),
            containerView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -252),
            containerView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 30),

            doneProfileUpdateLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            
            doneProfileUpdateLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor, constant: -15),
            doneProfileUpdateLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),

            doneProfileUpdateButton.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 0.133),
            doneProfileUpdateButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            doneProfileUpdateButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -30),
            doneProfileUpdateButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 30),
        ])
    }
}
