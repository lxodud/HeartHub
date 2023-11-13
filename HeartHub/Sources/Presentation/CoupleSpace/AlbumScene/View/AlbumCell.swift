//
//  CoupleSpaceAlbumCell.swift
//  HeartHub
//
//  Created by 이태영 on 2023/08/08.
//

import UIKit

final class AlbumCell: UICollectionViewCell {
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
        imageView.contentMode = .scaleToFill
        imageView.backgroundColor = .black
        imageView.clipsToBounds = false
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Pretendard-SemiBold", size: 20)
        return label
    }()
    
    private let optionButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "option"), for: .normal)
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
        configureSuperview()
        configureSubview()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(with contents: AlbumItemViewModel) {
        albumImageView.image = UIImage(data: contents.image)
        titleLabel.text = contents.title
        bodyLabel.text = contents.body
        creationDateLabel.text = contents.createdDate
        ddayLabel.text = contents.dday
    }
}

// MARK: Configure UI
extension AlbumCell {
    private func configureSuperview() {
        contentView.layer.borderColor = UIColor.lightGray.cgColor
        contentView.layer.borderWidth = 0.2
        contentView.layer.cornerRadius = 20
        contentView.clipsToBounds = true
    }
    
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
                equalTo: albumImageView.bottomAnchor,
                constant: 10
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
                equalTo: titleOptionStackView.bottomAnchor,
                constant: 5
            ),
            bodyLabel.leadingAnchor.constraint(
                equalTo: titleOptionStackView.leadingAnchor
            ),
            bodyLabel.trailingAnchor.constraint(
                equalTo: titleOptionStackView.trailingAnchor
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
