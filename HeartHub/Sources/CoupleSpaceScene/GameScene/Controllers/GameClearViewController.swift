//
//  GameClearViewController.swift
//  HeartHub
//
//  Created by 제민우 on 2023/08/05.
//

import UIKit

class GameClearViewController: UIViewController {
 
    private let clearMissionTableView = UITableView()
    
    var clearMissionDataArray: [String] = []
    private var clearMissionDataManager = GameClearMissionDataManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureClearMissionTableView()
        configureClearMissionTableViewLayout()
    }
}

// MARK: TableView Delegate Implement
extension GameClearViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let rowHeight = tableView.frame.height / CGFloat(4)
        return rowHeight
    }
}

// MARK: DataSource Implement
extension GameClearViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return clearMissionDataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: GameClearTableViewCell.reuseIdentifier, for: indexPath)
                as? GameClearTableViewCell else {
            return UITableViewCell()
        }
        
        cell.selectionStyle = .none
        cell.gameClearLabel.text = clearMissionDataArray[indexPath.item]
        
        return cell
    }
}

// MARK: Configure TableView
extension GameClearViewController {
    private func configureClearMissionTableView() {
        clearMissionTableView.delegate = self
        clearMissionTableView.dataSource = self
        
        clearMissionTableView.register(
            GameClearTableViewCell.self,
            forCellReuseIdentifier: GameClearTableViewCell.reuseIdentifier
        )
        
        clearMissionDataManager.configureMissionData()
        clearMissionDataArray = clearMissionDataManager.fetchGameMissionData()
        
        clearMissionTableView.separatorStyle = .none
        clearMissionTableView.backgroundColor = .clear
    }

    private func configureClearMissionTableViewLayout() {
        let safeArea = view.safeAreaLayoutGuide
        
        view.addSubview(clearMissionTableView)
        clearMissionTableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            clearMissionTableView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            clearMissionTableView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 43),
            clearMissionTableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            clearMissionTableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 25)
        ])
    }
}
