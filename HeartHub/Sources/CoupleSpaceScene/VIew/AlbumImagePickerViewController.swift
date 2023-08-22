//
//  AlbumImagePickerViewController.swift
//  HeartHub
//
//  Created by 전제윤 on 2023/08/21.
//

import UIKit
import PhotosUI

class AlbumImagePickerViewController: UIViewController  {

    private let albumImagePickerView = AlbumImagePickerView()
    
    private var postImages: [UIImage] = [UIImage(named: "AddPostImage")!]
    
    private var postCategoryButtonArray: [UIButton] = []
            
    override func loadView() {
        view = albumImagePickerView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureInitialSetting()
        configureNavigationBar()
    }
}

// MARK: Configure InitialSetting
extension AlbumImagePickerViewController {
    
    private func configureInitialSetting() {
        albumImagePickerView.albumCellPagingImageView.configureContents(self.postImages)
        
        albumImagePickerView.configureTapPostImageAction(self, #selector(configureSelectImageAlert))
    }
}

// MARK: Configure ActionSheet
extension AlbumImagePickerViewController {
    
    @objc private func configureSelectImageAlert() {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let library = UIAlertAction(title: "앨범", style: .default) { (action)
            in self.openLibrary()
        }
        let camera = UIAlertAction(title: "카메라", style: .default) { (action) in
            self.openCamera()
        }
        
        let cancel = UIAlertAction(title: "취소", style: .cancel)
                
        alert.addAction(library)
        alert.addAction(camera)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
    }
}

// MARK: Configure PHPicker

extension AlbumImagePickerViewController: PHPickerViewControllerDelegate {
    
    private func openLibrary() {
        var configuration = PHPickerConfiguration()
        configuration.selectionLimit = 10
        configuration.filter = .any(of: [.images])
        
        let phPickerVC = PHPickerViewController(configuration: configuration)
        phPickerVC.delegate = self
        self.present(phPickerVC, animated: true, completion: nil)
    }
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        postImages = []
        
        results.forEach { result in
            let itemProvider = result.itemProvider
            if itemProvider.canLoadObject(ofClass: UIImage.self) {
                itemProvider.loadObject(ofClass: UIImage.self) { image, error in
                    if let image = image as? UIImage {
                        self.postImages.append(image)
                        DispatchQueue.main.async {
                            self.albumImagePickerView.albumCellPagingImageView.configureContents(self.postImages)
                        }
                    }
                    if let error = error {
                        print("에러")
                    }
                }
            }
        }
        dismiss(animated: true)
    }
}

// MARK: Configure ImagePicker
extension AlbumImagePickerViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    private func openCamera() {
        if(UIImagePickerController.isSourceTypeAvailable(.camera)) {
            let addPostImagePicker = UIImagePickerController()
            
            addPostImagePicker.sourceType = .camera
            addPostImagePicker.delegate = self
            present(addPostImagePicker, animated: true, completion: nil)
        } else {
            print("Camera not available")
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? [UIImage] {
            albumImagePickerView.albumCellPagingImageView.configureContents(image)
            dismiss(animated: true)
        }
    }
}

// MARK: Configure NaviBar
extension AlbumImagePickerViewController {
    private func configureNavigationBar() {
        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(didTapBackButton))
        let doneButton = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(didTapDoneButton))
        
        backButton.tintColor = .black
        
        navigationItem.leftBarButtonItem = backButton
        navigationItem.rightBarButtonItem = doneButton
        navigationItem.title = "앨범 작성"
    }
    
    @objc private func didTapBackButton() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func didTapDoneButton() {
        // 게시물 등록
    }
}

