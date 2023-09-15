//
//  SignUpChangePageButtonView.swift
//  HeartHub
//
//  Created by 제민우 on 2023/08/07.
//

import UIKit

final class SignUpChangePageButton: UIButton {
    
    init(buttonImage: String) {
        super.init(frame: .zero)
        setImage(UIImage(named: buttonImage), for: .normal)
        
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SignUpChangePageButton {

    private func configureLayout() {
        let safeArea = safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: safeArea.topAnchor),
            bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
        ])
    }
}
