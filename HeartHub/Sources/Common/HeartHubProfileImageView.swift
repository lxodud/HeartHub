//
//  HeartHubProfileImageView.swift
//  HeartHub
//
//  Created by 이태영 on 2023/07/26.
//

import UIKit

final class HeartHubProfileImageView: UIImageView {
    init() {
        super.init(frame: .zero)
        contentMode = .scaleToFill
        clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = frame.height / 2
    }
}
