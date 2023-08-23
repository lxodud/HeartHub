//
//  ProfileResetView.swift
//  HeartHub
//
//  Created by 전제윤 on 2023/08/04.
//

import UIKit

final class ProfileResetView: UIView {
    
    private var backgroundGradientLayer: CAGradientLayer!
    
    var profileImageView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = UIColor(named: "softpink")
        view.layer.cornerRadius = 15
        view.layer.shadowColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.25).cgColor
        view.layer.shadowOpacity = 0.4
        view.layer.shadowOffset = CGSize(width: 2, height: 4)
        view.layer.shadowRadius = 1
        return view
    }()
    
    lazy var cameraButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "camera.fill"), for: .normal)
        button.tintColor = .white
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        return button
    }()
    
     lazy var nickNameLabel: UITextField = {
        var tf = UITextField()
        tf.backgroundColor = .clear
        tf.textColor = #colorLiteral(red: 0.07, green: 0.07, blue: 0.07, alpha: 0.5)
        tf.autocapitalizationType = .none
        tf.attributedPlaceholder = NSAttributedString(
                        string: "닉네임을 작성해주세요.",
                        attributes: [
                            NSAttributedString.Key.foregroundColor:
                                UIColor(red: 0.067, green: 0.067, blue: 0.067, alpha: 0.5),
                            NSAttributedString.Key.font:
                                UIFont(name: "Pretendard-Regular", size: 20)!
                                    ])
        tf.textAlignment = .center
        tf.tintColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
        return tf
    }()
    
    private lazy var infoLabel: UITextField = {
        var tf = UITextField()
        tf.backgroundColor = .clear
        tf.textColor = #colorLiteral(red: 0.07, green: 0.07, blue: 0.07, alpha: 0.5)
        tf.autocapitalizationType = .none
        tf.attributedPlaceholder = NSAttributedString(
                        string: "소개글을 입력해주세요.",
                        attributes: [
                            NSAttributedString.Key.foregroundColor:
                                UIColor(red: 0.067, green: 0.067, blue: 0.067, alpha: 0.5),
                            NSAttributedString.Key.font:
                                UIFont(name: "Pretendard-Regular", size: 16)!
                                    ])
        tf.textAlignment = .center
        tf.tintColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
        return tf
    }()
    
    let profileSetbtn: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.layer.cornerRadius = 15
        button.layer.shadowColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
        button.layer.shadowOpacity = 0.2
        button.layer.shadowOffset = CGSize(width: 2, height: 4)
        button.layer.shadowRadius = 1
        button.layer.borderWidth = 1
        button.layer.borderColor = #colorLiteral(red: 0.9819073081, green: 0.4734940529, blue: 0.8320614696, alpha: 1)
        button.setTitle("프로필로 적용하기", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.init(name: "Pretendard-SemiBold", size: 16)
        return button
    }()
    
    //MARK: - 뷰 초기화
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        applyGradientBackground()
        addViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - 뷰 추가 및 제약
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundGradientLayer.frame = bounds
    }
    
    private func applyGradientBackground() {
        backgroundGradientLayer = CAGradientLayer()
        backgroundGradientLayer.colors = [UIColor.white.cgColor, UIColor(named: "backgroundpink")!.cgColor] // 색상 순서 변경
        backgroundGradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
        backgroundGradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
        backgroundGradientLayer.frame = bounds
        layer.insertSublayer(backgroundGradientLayer, at: 0)
    }



    
    private func addViews() {
        [profileImageView, cameraButton, nickNameLabel, infoLabel, profileSetbtn].forEach{ addSubview($0)}
    }
    
    private func setConstraints() {
        profileImageViewConstraints()
        profileImageBtnConstraints()
        nickNameLabelConstraint()
        infoLabelConstraints()
        profileSetbtnConstraints()
    }
    
    private func profileImageViewConstraints() {
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            profileImageView.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            profileImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 80),
            profileImageView.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.25),
            profileImageView.widthAnchor.constraint(equalTo: profileImageView.heightAnchor)
        ])
    }
    
    private func profileImageBtnConstraints() {
        cameraButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cameraButton.trailingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: -10),
            cameraButton.bottomAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: -10),
            cameraButton.heightAnchor.constraint(equalTo: profileImageView.heightAnchor, multiplier: 0.13),
            cameraButton.widthAnchor.constraint(equalTo: profileImageView.widthAnchor, multiplier: 0.15)
        ])
    }
    
    private func nickNameLabelConstraint() {
        nickNameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nickNameLabel.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            nickNameLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 40),
            nickNameLabel.widthAnchor.constraint(equalTo: profileImageView.widthAnchor, multiplier: 1.4)
        ])
    }
    
    
    private func infoLabelConstraints() {
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            infoLabel.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            infoLabel.topAnchor.constraint(equalTo: nickNameLabel.bottomAnchor, constant: 15),
            infoLabel.widthAnchor.constraint(equalTo: profileImageView.widthAnchor)

        ])
    }
    
    private func profileSetbtnConstraints() {
        profileSetbtn.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            profileSetbtn.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            profileSetbtn.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 0.8),
            profileSetbtn.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -70),
            profileSetbtn.heightAnchor.constraint(equalTo: profileImageView.heightAnchor, multiplier: 0.3)
        ])
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        nickNameLabel.resignFirstResponder()
        infoLabel.resignFirstResponder()
    }
}


