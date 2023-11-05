//
//  ConnectViewController.swift
//  HeartHub
//
//  Created by 제민우 on 2023/08/15.
//

import UIKit

final class ConnectViewController: UIViewController {
    private let connectView = ConnectView()
    
    override func viewDidLoad() {
        configureSuperview()
        configureSubview()
        configureAddTarget()
        configureLayout()
    }
}

// MARK: - Configure Action
extension ConnectViewController {
    func configureAddTarget() {
        connectView.connectAccountButton.addTarget(self, action: #selector(didTapConnectAccountButton), for: .touchUpInside)
    }
    
    @objc private func didTapConnectAccountButton() {
        print("내 애인의 계정이 맞나요?")
        let connectCheckPopUpViewController = ConnectCheckPopUpViewController()
        connectCheckPopUpViewController.modalPresentationStyle = .overFullScreen
        present(connectCheckPopUpViewController, animated: true, completion: nil)
    }
}

// MARK: - Configure UI
extension ConnectViewController {
    private func configureSuperview() {
        view.backgroundColor = .systemBackground
    }
    
    private func configureSubview() {
        view.addSubview(connectView)
        connectView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configureLayout() {
        let safeArea = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            connectView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            connectView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            connectView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            connectView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor)
        ])
    }
}
