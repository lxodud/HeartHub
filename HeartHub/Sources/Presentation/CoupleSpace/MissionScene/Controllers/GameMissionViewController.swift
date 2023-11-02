//
//  GameMissionViewController.swift
//  HeartHub
//
//  Created by 제민우 on 2023/08/05.
//

import UIKit

class GameMissionViewController: UIViewController {
    private let gameMissionTableView = UITableView()
    
    var missionDataArray: [String] = []
    private var missionDataManager = GameMissionDataManager()
    
    override func viewDidLoad() {
        configureGameMissionTableView()
        configureGameMissionTableViewLayout()
    }
}

// MARK: TableView Delegate Implement
extension GameMissionViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let rowHeight = tableView.frame.height / CGFloat(4)
        return rowHeight
    }
}

// MARK: TableView DataSource Implement
extension GameMissionViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return missionDataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: GameMissionTableViewCell.reuseIdentifier, for: indexPath)
                as? GameMissionTableViewCell else {
            return UITableViewCell()
        }
        
        cell.selectionStyle = .none
        cell.gameMissionLabel.text = missionDataArray[indexPath.item]
        
        return cell
    }
}

// MARK: Configure TableView
extension GameMissionViewController {
    private func configureGameMissionTableView() {
        gameMissionTableView.delegate = self
        gameMissionTableView.dataSource = self
        
        gameMissionTableView.register(
            GameMissionTableViewCell.self,
            forCellReuseIdentifier: GameMissionTableViewCell.reuseIdentifier
        )
        
        missionDataManager.configureMissionData()
        missionDataArray = missionDataManager.fetchGameMissionData()
        
        gameMissionTableView.separatorStyle = .none
        gameMissionTableView.showsVerticalScrollIndicator = false
    }

    private func configureGameMissionTableViewLayout() {
        view.addSubview(gameMissionTableView)
        gameMissionTableView.backgroundColor = .clear
        gameMissionTableView.translatesAutoresizingMaskIntoConstraints = false
        
        // MARK: gameMissionTableView Constraints
        NSLayoutConstraint.activate([
            gameMissionTableView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            gameMissionTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 43),
            gameMissionTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            gameMissionTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 25),
        ])
    }
}
