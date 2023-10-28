//
//  GameClearTableViewCell.swift
//  HeartHub
//
//  Created by 제민우 on 2023/08/06.
//

import UIKit

final class GameClearTableViewCell: UITableViewCell {

    private lazy var gameMissionContainerShadowView: UIView = {
        let view = UIView()
        view.layer.shadowColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.1).cgColor
        view.layer.shadowOpacity = 1.0
        view.layer.shadowOffset = CGSize(width: 0, height: 4)
        view.layer.shadowRadius = 4
        view.addSubview(gameMissionContainverView)
        return view
    }()
    
    private var gameMissionContainverView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        return view
    }()
    
    var gameClearLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "DungGeunMo", size: 16)
        label.textAlignment = .left
        label.numberOfLines = 2
        return label
    }()
    
    private let gameMissionCheckImage: UIImageView = {
        var image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.backgroundColor = .clear
        image.image = UIImage(named: "MissionCheckImage")
        return image
        }()

    let gameClearButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "MissionCheckedButtonImage"), for: .normal)
        button.setImage(UIImage(named: "MissionUnCheckedButtonImage"), for: .selected)
        button.contentMode = .center
        return button
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        configureSubview()
        configureLayout()
        configureButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension GameClearTableViewCell {
    private func configureButton() {
        gameClearButton.addTarget(self, action: #selector(didTapMissionButton), for: .touchUpInside)
    }
    
    @objc private func didTapMissionButton() {

        if gameClearButton.isSelected == true {
            gameClearButton.isSelected = false
            gameMissionCheckImage.isHidden = false
         } else {
             gameClearButton.isSelected = true
             gameMissionCheckImage.isHidden = true
         }
    }
}

// MARK: Configure UI
extension GameClearTableViewCell {
    
    private func configureSubview() {
        self.backgroundColor = .clear

        [gameClearButton, gameClearLabel, gameMissionCheckImage].forEach {
            gameMissionContainverView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        self.contentView.addSubview(gameMissionContainerShadowView)
        gameMissionContainerShadowView.translatesAutoresizingMaskIntoConstraints = false
        gameMissionContainverView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configureLayout() {
        NSLayoutConstraint.activate([
            
            // MARK: gameMissionContainerShadowView Constraints
            gameMissionContainerShadowView.widthAnchor.constraint(equalTo: self.contentView.widthAnchor),
            gameMissionContainerShadowView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 12),
            gameMissionContainerShadowView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -12),
            gameMissionContainerShadowView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            
            // MARK: gameMissionContainerView Constraints
            gameMissionContainverView.topAnchor.constraint(equalTo: gameMissionContainerShadowView.topAnchor),
            gameMissionContainverView.bottomAnchor.constraint(equalTo: gameMissionContainerShadowView.bottomAnchor),
            gameMissionContainverView.leadingAnchor.constraint(equalTo: gameMissionContainerShadowView.leadingAnchor),
            gameMissionContainverView.trailingAnchor.constraint(equalTo: gameMissionContainerShadowView.trailingAnchor),

            // MARK: gameMissionButton Constraints
            gameClearButton.centerYAnchor.constraint(equalTo: gameMissionContainverView.centerYAnchor),
            gameClearButton.widthAnchor.constraint(equalTo: gameClearButton.heightAnchor),
            gameClearButton.topAnchor.constraint(equalTo: gameMissionContainverView.topAnchor, constant: 24),
            gameClearButton.leadingAnchor.constraint(equalTo: gameMissionContainverView.leadingAnchor, constant: 20),
            
            gameMissionCheckImage.topAnchor.constraint(equalTo: gameClearButton.topAnchor, constant: -7),
            gameMissionCheckImage.bottomAnchor.constraint(equalTo: gameClearButton.bottomAnchor, constant: -2),
            gameMissionCheckImage.leadingAnchor.constraint(equalTo: gameClearButton.leadingAnchor, constant: 1),
            gameMissionCheckImage.trailingAnchor.constraint(equalTo: gameClearButton.trailingAnchor, constant: 6),

            // MARK: gameMissionLabel Constraints
            gameClearLabel.widthAnchor.constraint(equalTo: gameMissionContainverView.widthAnchor, multiplier: 0.74),
            gameClearLabel.centerYAnchor.constraint(equalTo: gameMissionContainverView.centerYAnchor),
            gameClearLabel.leadingAnchor.constraint(equalTo: gameClearButton.trailingAnchor, constant: 18),
            gameClearLabel.trailingAnchor.constraint(equalTo: gameMissionContainverView.trailingAnchor, constant: -20)
        ])
    }
}
