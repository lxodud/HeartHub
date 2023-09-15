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
        super.viewDidLoad()
        configureAddTarget()
        configureSubviews()
        configureLayout()
        configureNavigationBar()
    }
}

// MARK: Configure addTarget
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

extension ConnectViewController {
    private func configureSubviews() {
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
    
    private func configureNavigationBar() {
        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(didTapBackButton))
        backButton.tintColor = .black
        navigationItem.leftBarButtonItem = backButton
        navigationItem.title = "계정 연동"
    }
    
    @objc private func didTapBackButton() {
        navigationController?.popViewController(animated: true)
    }
}
