//
//  AddPostViewController.swift
//  HeartHub
//
//  Created by 제민우 on 2023/08/16.
//

import UIKit
import PhotosUI

final class AddPostViewController: UIViewController {

    private let addPostView = AddPostView()
    
    private var postImages: [UIImage] = [UIImage(named: "AddPostImage")!]
    
    private var postCategoryButtonArray: [UIButton] = []
            
    override func loadView() {
        view = addPostView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureButtonAction()
        configureInitialSetting()
    }
}

// MARK: Configure InitialSetting
extension AddPostViewController {
    
    private func configureInitialSetting() {
        addPostView.addPostProfileView.configureContents(mockData[0])
        addPostView.addPostCellPagingImageView.configureContents(self.postImages)
        
        addPostView.configureTapPostImageAction(self, #selector(configureSelectImageAlert))
    }
}

// MARK: Configure ActionSheet
extension AddPostViewController {
    
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
extension AddPostViewController: PHPickerViewControllerDelegate {
    
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
                            self.addPostView.addPostCellPagingImageView.configureContents(self.postImages)
                        }
                    }
                    if let error = error {
                        print(error)
                    }
                }
            }
        }
        dismiss(animated: true)
    }
}

// MARK: Configure ImagePicker
extension AddPostViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
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
            addPostView.addPostCellPagingImageView.configureContents(image)
            dismiss(animated: true)
        }
    }
}

// MARK: Configure AddTarget
extension AddPostViewController {
    private func configureButtonAction() {
        let dailyButton = addPostView.addPostDailyButton
        let lookButton = addPostView.addPostLookButton
        let dateButton = addPostView.addPostDateButton

        postCategoryButtonArray.append(dailyButton)
        postCategoryButtonArray.append(lookButton)
        postCategoryButtonArray.append(dateButton)
        
        for (index, button) in postCategoryButtonArray.enumerated() {
            button.addTarget(self, action: #selector(didTapPostCategoryButton(_:)), for: .touchUpInside)
            button.tag = index
        }
    }
    
    @objc private func didTapPostCategoryButton(_ sender: UIButton) {
        self.postCategoryButtonArray.forEach {
            if $0.tag == sender.tag {
                $0.isSelected = true
                $0.backgroundColor = $0.isSelected ? .black : .white
            } else {
                $0.isSelected = false
                $0.backgroundColor = .white
            }
        }
    }
}

// MARK: Configure NaviBar
extension AddPostViewController {
    private func configureNavigationBar() {
        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(didTapBackButton))
        let doneButton = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(didTapDoneButton))
        
        backButton.tintColor = .black
        
        navigationItem.leftBarButtonItem = backButton
        navigationItem.rightBarButtonItem = doneButton
        navigationItem.title = "게시물 작성"
    }
    
    @objc private func didTapBackButton() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func didTapDoneButton() {
        // 게시물 등록
    }
}
