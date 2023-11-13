//
//  AlbumCoordinator.swift
//  HeartHub
//
//  Created by 이태영 on 2023/11/09.
//

import UIKit

final class AlbumCoordinor {
    private let navigationController: UINavigationController
    private weak var albumPostViewController: UIViewController?
    private let imagePickerViewController: HeartHubImagePickerViewController = {
        let viewController = HeartHubImagePickerViewController()
        
        return viewController
    }()
    private let albumUseCase = AlbumUseCase()
    
    private lazy var backButton = UIBarButtonItem(
        image: UIImage(systemName: "chevron.left"),
        style: .plain,
        target: self,
        action: #selector(didTapBackButton)
    )
    
    // MARK: - initialzier
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    @objc private func didTapBackButton() {
        navigationController.popViewController(animated: true)
    }
}

// MARK: Public Interface
extension AlbumCoordinor: AlbumCoordinatable {
    func start() {
        let coupleSpaceAlbumViewController = AlbumViewController(
            viewModel: AlbumViewModel(
                coordinator: self,
                albumUseCase: albumUseCase
            )
        )
        coupleSpaceAlbumViewController.navigationItem.leftBarButtonItem = backButton
        
        navigationController.pushViewController(coupleSpaceAlbumViewController, animated: true)
    }
    
    func toPost() {
        let albumPostViewModel = AlbumPostViewModel(
            coordinator: self,
            albumUseCase: albumUseCase
        )
        imagePickerViewController.delegate = albumPostViewModel
        
        let albumPostViewController = UINavigationController(
            rootViewController: AlbumPostViewController(
                viewModel: albumPostViewModel
            )
        )
        
        self.albumPostViewController = albumPostViewController
        
        albumPostViewController.modalPresentationStyle = .fullScreen
        navigationController.present(albumPostViewController, animated: true)
    }
    
    func toImagePicker() {
        let navigationController = UINavigationController(
            rootViewController: imagePickerViewController
        )
        navigationController.modalPresentationStyle = .fullScreen
        albumPostViewController?.present(navigationController, animated: true)
    }
    
    func finish() {
        navigationController.dismiss(animated: true)
    }
}
