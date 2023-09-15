//
//  SignUpBackgroundView.swift
//  HeartHub
//
//  Created by 제민우 on 2023/08/07.
//

import UIKit

final class SignUpBackgroundView: UIView {

    private var signUpHeartImageView: UIImageView = {
            var img = UIImageView()
            img.contentMode = .scaleAspectFit
            img.backgroundColor = .clear
            return img
        }()
    
    private var signUpOurStartLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Pretendard-SemiBold", size: 20)
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        label.textColor = #colorLiteral(red: 0.07, green: 0.07, blue: 0.07, alpha: 1)
        return label
    }()
    
    private var signUpDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Pretendard-Regular", size: 14)
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        label.textColor = #colorLiteral(red: 0.46, green: 0.46, blue: 0.46, alpha: 1)
        return label
    }()
    
    // 두 레이블 묶는 스택뷰
    private lazy var signUpMainLabelStackView: UIStackView = {
        let stView = UIStackView(arrangedSubviews: [signUpOurStartLabel, signUpDescriptionLabel])
        stView.spacing = 3.5
        stView.axis = .vertical
        stView.distribution = .fill
        stView.alignment = .fill
        return stView
    }()
    
    init(heartImage: String, ourStartLabelText: String, descriptionLabelText: String) {
        super.init(frame: .zero)
        signUpHeartImageView.image = UIImage(named: heartImage)
        signUpOurStartLabel.text = ourStartLabelText
        signUpDescriptionLabel.text = descriptionLabelText
        
        configureInitialSetting()
        configureSubviews()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SignUpBackgroundView {
    
    private func configureInitialSetting() {
        backgroundColor = .white
    }
    
    private func configureSubviews() {
        [signUpHeartImageView,
         signUpMainLabelStackView].forEach {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }

    private func configureLayout() {
        let safeArea = safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            // MARK: heartImg1View Constraints
            signUpHeartImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            signUpHeartImageView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            
            // MARK: startLabelStackView Constraints
            signUpMainLabelStackView.topAnchor.constraint(equalTo: signUpHeartImageView.bottomAnchor, constant: 34),
            signUpMainLabelStackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 32),
            signUpMainLabelStackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -76),
        ])
    }
}
