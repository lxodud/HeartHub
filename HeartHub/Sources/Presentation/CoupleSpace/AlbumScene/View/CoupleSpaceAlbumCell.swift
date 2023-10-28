//
//  CoupleSpaceAlbumCell.swift
//  HeartHub
//
//  Created by 이태영 on 2023/08/08.
//

import UIKit

final class CoupleSpaceAlbumCell: UICollectionViewCell {
    private let firstDecorationView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.951, green: 0.77, blue: 0.896, alpha: 0.2)
        view.layer.cornerRadius = 20
        return view
    }()
    
    private let secondDecorationView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.98, green: 0.184, blue: 0.741, alpha: 0.2)
        view.layer.cornerRadius = 20
        return view
    }()
    
    private let albumImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "TestImage")
        imageView.backgroundColor = .black
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Pretendard-SemiBold", size: 20)
        label.text = "안녕 히히"
        return label
    }()
    
    private let optionButton: UIButton = {
        let button = UIButton()
        return button
    }()
    
    private let titleOptionStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fill
        return stackView
    }()
    
    private let bodyLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Pretendard-Regular", size: 16)
        return label
    }()
    
    private let creationDateLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0.6, green: 0.6, blue: 0.6, alpha: 0.6)
        label.font = UIFont(name: "Pretendard-Regular", size: 12)
        return label
    }()
    
    private let ddayLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0.6, green: 0.6, blue: 0.6, alpha: 0.6)
        label.font = UIFont(name: "Pretendard-Regular", size: 12)
        return label
    }()
    
    private let creationDateDdayStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fill
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        configureDecorateView()
        configureSubview()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Configure UI
extension CoupleSpaceAlbumCell {
    private func configureSubview() {
        [titleLabel, optionButton].forEach {
            titleOptionStackView.addArrangedSubview($0)
        }
        
        [creationDateLabel, ddayLabel].forEach {
            creationDateDdayStackView.addArrangedSubview($0)
        }
        
        [albumImageView, titleOptionStackView, bodyLabel, creationDateDdayStackView].forEach {
            contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        clipsToBounds = false
        contentView.layer.cornerRadius = 20
        contentView.clipsToBounds = true
    }
    
    private func configureLayout() {
        let safeArea = contentView.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            // MARK: albumImageView Constraints
            albumImageView.topAnchor.constraint(
                equalTo: contentView.topAnchor
            ),
            albumImageView.leadingAnchor.constraint(
                equalTo: safeArea.leadingAnchor
            ),
            albumImageView.trailingAnchor.constraint(
                equalTo: safeArea.trailingAnchor
            ),
            albumImageView.heightAnchor.constraint(
                equalTo: safeArea.heightAnchor,
                multiplier: 2/3
            ),
            
            // MARK: titleOptionStackView Constraints
            titleOptionStackView.topAnchor.constraint(
                equalTo: albumImageView.bottomAnchor
            ),
            titleOptionStackView.leadingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.leadingAnchor,
                constant: 15
            ),
            titleOptionStackView.trailingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.trailingAnchor,
                constant: -15
            ),
            
            // MARK: bodyLabel Constraints
            bodyLabel.topAnchor.constraint(
                equalTo: titleOptionStackView.bottomAnchor
            ),
            bodyLabel.leadingAnchor.constraint(
                equalTo: titleOptionStackView.leadingAnchor
            ),
            bodyLabel.trailingAnchor.constraint(
                equalTo: titleOptionStackView.trailingAnchor
            ),
            bodyLabel.bottomAnchor.constraint(
                greaterThanOrEqualTo: creationDateDdayStackView.topAnchor
            ),
            
            // MARK: creationDateDdayStackView Constratins
            creationDateDdayStackView.leadingAnchor.constraint(
                equalTo: titleOptionStackView.leadingAnchor
            ),
            creationDateDdayStackView.trailingAnchor.constraint(
                equalTo: titleOptionStackView.trailingAnchor
            ),
            creationDateDdayStackView.bottomAnchor.constraint(
                equalTo: safeArea.bottomAnchor,
                constant: -15
            ),
        ])
    }
    
    private func configureDecorateView() {
        [firstDecorationView, secondDecorationView].forEach {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            firstDecorationView.bottomAnchor.constraint(
                equalTo: secondDecorationView.topAnchor,
                constant: 40
            ),
            firstDecorationView.widthAnchor.constraint(
                equalTo: contentView.widthAnchor,
                multiplier: 0.9
            ),
            firstDecorationView.heightAnchor.constraint(
                equalToConstant: 50
            ),
            firstDecorationView.centerXAnchor.constraint(
                equalTo: contentView.centerXAnchor
            ),
            
            secondDecorationView.bottomAnchor.constraint(
                equalTo: contentView.topAnchor,
                constant: 20
            ),
            secondDecorationView.widthAnchor.constraint(
                equalTo: contentView.widthAnchor,
                multiplier: 0.95
            ),
            secondDecorationView.heightAnchor.constraint(
                equalToConstant: 30
            ),
            secondDecorationView.centerXAnchor.constraint(
                equalTo: contentView.centerXAnchor
            ),
        ])
    }
}
