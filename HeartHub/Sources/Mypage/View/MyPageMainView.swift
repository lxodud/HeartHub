//
//  MyPageMainScene.swift
//  HeartHub
//
//  Created by 전제윤 on 2023/07/31.
//

import UIKit

final class MyPageMainView: UIView {
    
    private let pinkWaveImage: UIImageView = {
        var img = UIImageView()
        img.contentMode = .scaleAspectFit
        img.image = UIImage(named: "Pinkwave")
        return img
    }()
    
    var profileImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 40
        image.layer.shadowColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.25).cgColor
        image.layer.shadowOpacity = 1.0
        image.layer.shadowOffset = CGSize(width: 0, height: 4)
        image.layer.shadowRadius = 4
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
     var profileNickname: UILabel = {
        let name = UILabel()
        name.text = "우리 자기 사랑행행"
        name.textAlignment = .center
        name.font = UIFont(name: "Pretendard-SemiBold", size: 16)
        name.textColor = .black
        return name
    }()
    
    lazy var profileResetBtn: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = .clear
        button.setTitle("프로필 수정", for: .normal)
        button.titleLabel?.font = UIFont.init(name: "Pretendard-SemiBold", size: 18)
        button.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        return button
    }()
    
    lazy var questionBtn: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = .clear
        button.setTitle("1 : 1 문의", for: .normal)
        button.titleLabel?.font = UIFont.init(name: "Pretendard-SemiBold", size: 18)
        button.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        return button
    }()
    
    lazy var alertSettingBtn: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = .clear
        button.setTitle("알림설정", for: .normal)
        button.titleLabel?.font = UIFont.init(name: "Pretendard-SemiBold", size: 18)
        button.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        return button
    }()
    
    lazy var membershipWithdrawalBtn: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = .clear
        button.setTitle("회원탈퇴", for: .normal)
        button.titleLabel?.font = UIFont.init(name: "Pretendard-SemiBold", size: 18)
        button.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        return button
    }()
    
    lazy var pwdChangeBtn: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = .clear
        button.setTitle("비밀번호 변경", for: .normal)
        button.titleLabel?.font = UIFont.init(name: "Pretendard-SemiBold", size: 18)
        button.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        return button
    }()
    
    lazy var logOutBtn: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = .clear
        button.setTitle("로그아웃", for: .normal)
        button.titleLabel?.font = UIFont.init(name: "Pretendard-SemiBold", size: 18)
        button.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        return button
    }()
    
    private lazy var lineView1: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        return view
    }()
    
    private lazy var lineView2: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        return view
    }()
    
    private lazy var lineView3: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        return view
    }()
    
    private lazy var lineView4: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        return view
    }()
    
    private lazy var lineView5: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        return view
    }()
    
    private lazy var lineView6: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        return view
    }()
    
    private lazy var stactView: UIStackView = {
        let stackview = UIStackView(arrangedSubviews:  [ profileResetBtn, lineView1, questionBtn, lineView2,  alertSettingBtn, lineView3, membershipWithdrawalBtn, lineView4, pwdChangeBtn, lineView5, logOutBtn, lineView6])
        stackview.spacing = 20
        stackview.axis = .vertical
        stackview.alignment = .leading
        stackview.distribution = .fillProportionally
        return stackview
    }()
    
    private let buttonViewHeight: CGFloat = 48
    
    //MARK: - 뷰 초기화
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addViews()
        setConstraints()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - 뷰 추가 및 제약
    
    private func addViews() {
        [pinkWaveImage, profileImageView, profileNickname, stactView].forEach { addSubview($0) }
    }
    
    private func setConstraints() {
        pinkWaveImageConstraints()
        imageShadowViewConstriants()
        proNicknameViewConstriants()
        stackViewConstriants()
        lineView1Constraints()
        lineView2Constraints()
        lineView3Constraints()
        lineView4Constraints()
        lineView5Constraints()
        lineView6Constraints()
    }
    
    func updateProfileImage(_ image: UIImage) {
        profileImageView.image = image
    }
    
    private func pinkWaveImageConstraints() {
        pinkWaveImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pinkWaveImage.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            pinkWaveImage.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 400),
            pinkWaveImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            pinkWaveImage.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    private func imageShadowViewConstriants() {
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            profileImageView.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            profileImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 40),
            profileImageView.heightAnchor.constraint(equalToConstant: 100),
            profileImageView.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    
    private func proNicknameViewConstriants() {
        profileNickname.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
                    profileNickname.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
                    profileNickname.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 15),
                    profileNickname.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    private func stackViewConstriants() {
        stactView.spacing = 10
        stactView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stactView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 40),
            stactView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -40),
            stactView.topAnchor.constraint(equalTo: profileNickname.bottomAnchor, constant: 30),
            stactView.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.43)
        ])
    }
    
    private func lineView1Constraints() {
        lineView1.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            lineView1.widthAnchor.constraint(equalTo: stactView.widthAnchor, multiplier: 1),
            lineView1.heightAnchor.constraint(equalToConstant: buttonViewHeight*0.01)
        ])
    }
    
    private func lineView2Constraints() {
        lineView2.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            lineView2.widthAnchor.constraint(equalTo: stactView.widthAnchor, multiplier: 1),
            lineView2.heightAnchor.constraint(equalToConstant: buttonViewHeight*0.01)
        ])
    }
    
    private func lineView3Constraints() {
        lineView3.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            lineView3.widthAnchor.constraint(equalTo: stactView.widthAnchor, multiplier: 1),
            lineView3.heightAnchor.constraint(equalToConstant: buttonViewHeight*0.01)
        ])
    }
    
    private func lineView4Constraints() {
        lineView4.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            lineView4.widthAnchor.constraint(equalTo: stactView.widthAnchor, multiplier: 1),
            lineView4.heightAnchor.constraint(equalToConstant: buttonViewHeight*0.01)
        ])
    }
    
    private func lineView5Constraints() {
        lineView5.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            lineView5.widthAnchor.constraint(equalTo: stactView.widthAnchor, multiplier: 1),
            lineView5.heightAnchor.constraint(equalToConstant: buttonViewHeight*0.01)
        ])
    }
    
    private func lineView6Constraints() {
        lineView6.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            lineView6.widthAnchor.constraint(equalTo: stactView.widthAnchor, multiplier: 1),
            lineView6.heightAnchor.constraint(equalToConstant: buttonViewHeight*0.01)
        ])
    }
}

