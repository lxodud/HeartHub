//
//  PostArticleViewController.swift
//  HeartHub
//
//  Created by 제민우 on 2023/08/16.
//

import UIKit
import PhotosUI

final class PostArticleViewController: UIViewController {

    private let postArticleView = PostArticleView()
    private var postImages: [UIImage] = [UIImage(named: "AddPostImage")!]
    private var postCategoryButtonArray: [UIButton] = []
    private var articleTheme: ArticleTheme = .daily
    
    private let postArticleDataSource: PostArticleDataSource
    
    init(postArticleDataSource: PostArticleDataSource) {
        self.postArticleDataSource = postArticleDataSource
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = postArticleView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        configureButtonAction()
        configureInitialSetting()
        configureNavigationBar()
        bind(to: postArticleDataSource)
        postArticleDataSource.fetchUserInformation()
    }
    
    private func bind(to dataSource: PostArticleDataSource) {
        dataSource.userInformationPublisher = { [weak self] username, imageData in
            guard let image = UIImage(data: imageData) else {
                return
            }
            
            self?.postArticleView.postArticleProfileView.configureContents(username, image)
        }
    }
}

// MARK: Configure InitialSetting
extension PostArticleViewController {
    
    private func configureInitialSetting() {
        postArticleView.postArticleCellPagingImageView.configureContents(self.postImages)
        postArticleView.configureTapPostImageAction(self, #selector(configureSelectImageAlert))
    }
    
    private func configureNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "완료",
            style: .plain,
            target: self,
            action: #selector(tapDoneButton)
        )
    }
    
    @objc
    private func tapDoneButton() {
        navigationItem.rightBarButtonItem?.isEnabled = false
        guard var content = postArticleView.postArticleTextView.text else {
            navigationItem.rightBarButtonItem?.isEnabled = true
            return
        }
        
        if UIImage(named: "AddPostImage") == postImages.first {
            postImages.removeAll()
        }
        
        if postArticleView.postArticleTextView.text == "문구를 입력해주세요." {
            content = ""
        }
        
        let imageData = postImages.map { image in
            guard let resizeImage = image.resizeWithWidth(width: 400),
                  let imageData = resizeImage.pngData()
            else {
                return Data()
            }
            
            return imageData
        }
        postArticleDataSource.postArticle(
            imageData,
            content,
            articleTheme
        ) {
            self.navigationController?.popViewController(animated: true)
        }
    }
}

// MARK: Configure ActionSheet
extension PostArticleViewController {
    
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
extension PostArticleViewController: PHPickerViewControllerDelegate {
    
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
                            self.postArticleView.postArticleCellPagingImageView.configureContents(self.postImages)
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
extension PostArticleViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
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
            postArticleView.postArticleCellPagingImageView.configureContents(image)
            dismiss(animated: true)
        }
    }
}

// MARK: Configure AddTarget
extension PostArticleViewController {
    private func configureButtonAction() {
        let dailyButton = postArticleView.postArticleDailyButton
        let lookButton = postArticleView.postArticleLookButton
        let dateButton = postArticleView.postArticleDateButton

        postCategoryButtonArray.append(dailyButton)
        postCategoryButtonArray.append(lookButton)
        postCategoryButtonArray.append(dateButton)
        
        for (index, button) in postCategoryButtonArray.enumerated() {
            button.addTarget(self, action: #selector(didTapPostCategoryButton(_:)), for: .touchUpInside)
            button.tag = index
        }
    }
    
    @objc private func didTapPostCategoryButton(_ sender: PostArticleButton) {
        self.articleTheme = sender.theme
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

fileprivate extension UIImage {
    func resizeWithWidth(width: CGFloat) -> UIImage? {
        let imageView = UIImageView(frame: CGRect(origin: .zero, size: CGSize(width: width, height: CGFloat(ceil(width/size.width * size.height)))))
        imageView.contentMode = .scaleAspectFit
        imageView.image = self
        UIGraphicsBeginImageContextWithOptions(imageView.bounds.size, false, scale)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        imageView.layer.render(in: context)
        guard let result = UIGraphicsGetImageFromCurrentImageContext() else { return nil }
        UIGraphicsEndImageContext()
        return result
    }
}
