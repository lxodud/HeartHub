//
//  heartHubModalView.swift
//  HeartHub
//
//  Created by 제민우 on 2023/07/16.
//

import UIKit

final class FindIdPopUpView: UIView {
        
    // MARK: 레이블
    private lazy var userNickNameLabel: UILabel = {
        let label = UILabel()
        label.text = "메일로 아이디가\n 전송되었습니다."
        label.numberOfLines = 2
        label.textAlignment = .center
        label.font = UIFont(name: "Pretendard-SemiBold", size: 24)
        label.adjustsFontForContentSizeCategory = true
        label.textColor = .black
        return label
    }()
    
    // 종이비행기 이미지뷰
    private let paperPlaneImgView: UIImageView = {
        var imgView = UIImageView()
        imgView.contentMode = .scaleAspectFit
        imgView.image = UIImage(named: "PaperPlane.png")
        return imgView
    }()

    // MARK: 닫기버튼
    lazy var closeBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.backgroundColor = .white
        btn.layer.borderWidth = 1
        btn.layer.cornerRadius = 18
        btn.layer.borderColor = #colorLiteral(red: 0.9803773761, green: 0.1853338182, blue: 0.7394250631, alpha: 1)
 
        btn.setTitle("닫기", for: .normal)
        btn.titleLabel?.font = UIFont.init(name: "Pretendard-Regular", size: 14)
        btn.titleLabel?.textAlignment = .center
        btn.setTitleColor(UIColor(red: 0.067, green: 0.067, blue: 0.067, alpha: 1), for: .normal)
        btn.sizeToFit()
        btn.titleLabel?.adjustsFontSizeToFitWidth = true
        btn.titleLabel?.numberOfLines = 1
        
        btn.layer.shadowColor = UIColor(red: 0.98, green: 0.184, blue: 0.741, alpha: 0.25).cgColor
        btn.layer.shadowOpacity = 1.0
        btn.layer.shadowOffset = CGSize(width: 0, height: 4)
        btn.layer.shadowRadius = 6
        
        return btn
    }()
    
    private lazy var labelImgStackView: UIStackView = {
        let stView = UIStackView(arrangedSubviews: [userNickNameLabel, paperPlaneImgView, closeBtn])
        stView.axis = .vertical
        stView.spacing = 34
        stView.setCustomSpacing(81, after: paperPlaneImgView)
        stView.alignment = .center
        stView.distribution = .fillProportionally
        return stView
    }()
    
    
    lazy var containerView: UIView = {
       let view = UIView()
        view.backgroundColor = .white
        view.clipsToBounds = true
        view.layer.cornerRadius = 18
        view.addSubview(labelImgStackView)
        return view
    }()
    
    // MARK: 뷰 초기화
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(red: 0.067, green: 0.067, blue: 0.067, alpha: 0.2)
        addViews()
        constraints()
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: 제약
    private func addViews() {
        
        [containerView,
        labelImgStackView,
         closeBtn].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        
        addSubview(containerView)
    }
    
    private func constraints() {
        
        let safeArea = safeAreaLayoutGuide

        NSLayoutConstraint.activate([
            containerView.centerXAnchor.constraint(equalTo: centerXAnchor),
            containerView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 138),
            containerView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -163),
            containerView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 30),

            labelImgStackView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            labelImgStackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 119),
            labelImgStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -30),
            labelImgStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),

            closeBtn.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 0.08),
            closeBtn.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            closeBtn.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 30),
        ])
    }
}
