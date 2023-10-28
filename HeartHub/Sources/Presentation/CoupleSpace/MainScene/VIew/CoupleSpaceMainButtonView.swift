//
//  CoupleSpaceMainButtonView.swift
//  HeartHub
//
//  Created by 이태영 on 2023/08/02.
//

import UIKit

final class CoupleSpaceMainButtonView: UIView {
    private let buttonImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let buttonLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Pretendard-SemiBold", size: 16)
        return label
    }()
    
    private let totalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 15
        return stackView
    }()
    
    init(image: UIImage?, title: String) {
        super.init(frame: .zero)
        configureInitialSetting()
        configureContents(image: image, title: title)
        configureSubview()
        configureLayout()
        configureShadow()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Public Interface
extension CoupleSpaceMainButtonView {
    func addAction(_ target: Any,_ action: Selector) {
        let tapGesture = UITapGestureRecognizer(target: target, action: action)
        addGestureRecognizer(tapGesture)
    }
}

// MARK: Configure UI
extension CoupleSpaceMainButtonView {
    private func configureInitialSetting() {
        backgroundColor = .systemBackground
        layer.cornerRadius = 20
    }
    
    private func configureContents(image: UIImage?, title: String) {
        buttonLabel.text = title
        buttonImageView.image = image
    }
    
    private func configureSubview() {
        [buttonImageView, buttonLabel].forEach {
            totalStackView.addArrangedSubview($0)
        }
        
        addSubview(totalStackView)
        buttonImageView.translatesAutoresizingMaskIntoConstraints = false
        totalStackView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configureLayout() {
        let safeArea = safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            // MARK: totalStackView Constraints
            totalStackView.heightAnchor.constraint(
                equalTo: safeArea.heightAnchor,
                multiplier: 0.7
            ),
            totalStackView.leadingAnchor.constraint(
                equalTo: safeArea.leadingAnchor
            ),
            totalStackView.trailingAnchor.constraint(
                equalTo: safeArea.trailingAnchor
            ),
            totalStackView.centerYAnchor.constraint(
                equalTo: safeArea.centerYAnchor
            ),
            
            // MARK: buttonImageView Constraints
            buttonImageView.heightAnchor.constraint(
                equalTo: totalStackView.heightAnchor,
                multiplier: 0.5
            ),
            buttonImageView.widthAnchor.constraint(
                equalTo: buttonImageView.widthAnchor
            )
        ])
    }
    
    private func configureShadow() {
        layer.shadowColor = UIColor.black.cgColor
        layer.masksToBounds = false
        layer.shadowOffset = CGSize(width: 0, height: 4)
        layer.shadowRadius = 5
        layer.shadowOpacity = 0.3
    }
}
