//
//  HeartHubImagePickerCell.swift
//  HeartHub
//
//  Created by 이태영 on 2023/08/03.
//

import UIKit

final class HeartHubImagePickerCell: UICollectionViewCell {
    let imageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        configureSubview()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Configure UI
extension HeartHubImagePickerCell {
    private func configureSubview() {
        [imageView].forEach {
            contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    private func configureLayout() {
        let safeArea = contentView.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            // MARK: imageView Constraints
            imageView.topAnchor.constraint(
                equalTo: safeArea.topAnchor
            ),
            imageView.leadingAnchor.constraint(
                equalTo: safeArea.leadingAnchor
            ),
            imageView.trailingAnchor.constraint(
                equalTo: safeArea.trailingAnchor
            ),
            imageView.bottomAnchor.constraint(
                equalTo: safeArea.bottomAnchor
            ),
        ])
    }
}
