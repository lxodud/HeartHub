//
//  CommunityGameBackgroundView.swift
//  HeartHub
//
//  Created by 제민우 on 2023/08/02.
//

import UIKit

final class GameBackgroundView: UIView {

    private var gameBackgroundImageView: UIImageView = {
        var img = UIImageView()
        img.contentMode = .scaleAspectFit
        img.backgroundColor = .clear
        img.image = UIImage(named: "GameBackGround.png")
        return img
    }()
    
    private var gameFrontMountainImageView: UIImageView = {
        var img = UIImageView()
        img.contentMode = .scaleAspectFit
        img.backgroundColor = .clear
        img.image = UIImage(named: "GameMountainFront.png")
        return img
    }()
    
    private var missionTitleImageView: UIImageView = {
        var img = UIImageView()
        img.contentMode = .scaleAspectFit
        img.backgroundColor = .clear
        img.image = UIImage(named: "GameMissionTitle.png")
        return img
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureSubview()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Configure UI
extension GameBackgroundView {
    func configureSubview() {
        [gameBackgroundImageView,
         missionTitleImageView,
         gameFrontMountainImageView,
         ].forEach {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    func configureLayout() {
        NSLayoutConstraint.activate([
            // MARK: gmaeBackgroundImageView Constraints
            gameBackgroundImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            gameBackgroundImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            gameBackgroundImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            gameBackgroundImageView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            
            // MARK: missionTitleImageView Constraints
            missionTitleImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            missionTitleImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            missionTitleImageView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 111),
            
            // MARK: gameFrontMountainImageView Constraints
            gameFrontMountainImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            gameFrontMountainImageView.topAnchor.constraint(equalTo: missionTitleImageView.topAnchor, constant: 546),
            gameFrontMountainImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 41.5),
            gameFrontMountainImageView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
        ])
    }
}
