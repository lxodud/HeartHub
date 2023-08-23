//
//  RrofileResetViewController.swift
//  HeartHub
//
//  Created by 전제윤 on 2023/08/19.
//

import UIKit

final class ProfileResetViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate, UITextFieldDelegate {
    
    private let profileResetView = ProfileResetView()
    private var myPageMainView: MyPageMainView?
    
    override func loadView() {
        view = profileResetView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAddTarget()
        myPageMainView = MyPageMainView()
        
        profileResetView.nickNameLabel.delegate = self
    }
    
    func setupAddTarget() {
        profileResetView.cameraButton.addTarget(self, action: #selector(showImagePicker), for: .touchUpInside)
        profileResetView.profileSetbtn.addTarget(self, action: #selector(didTapProfileSetButton), for: .touchUpInside)
        
    }
    
    @objc private func didTapCameraButton() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let cameraAction = UIAlertAction(title: "카메라", style: .default) { _ in
            imagePickerController.sourceType = .camera
            self.present(imagePickerController, animated: true, completion: nil)
        }
        alertController.addAction(cameraAction)
        
        let albumAction = UIAlertAction(title: "앨범", style: .default) { _ in
            imagePickerController.sourceType = .photoLibrary
            self.present(imagePickerController, animated: true, completion: nil)
        }
        alertController.addAction(albumAction)
        
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    // UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    @objc private func showImagePicker() {
        print("이미지피커 동작")
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let cameraAction = UIAlertAction(title: "카메라", style: .default) { _ in
            imagePickerController.sourceType = .camera
            self.present(imagePickerController, animated: true, completion: nil)
        }
        alertController.addAction(cameraAction)
        
        let albumAction = UIAlertAction(title: "앨범", style: .default) { _ in
            imagePickerController.sourceType = .photoLibrary
            self.present(imagePickerController, animated: true, completion: nil)
        }
        alertController.addAction(albumAction)
        
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        
        if let selectedImage = info[.originalImage] as? UIImage {
            profileResetView.profileImageView.image = selectedImage
        }
    }
    
    
    @objc private func didTapProfileSetButton() {
        guard let nickname = profileResetView.nickNameLabel.text, !nickname.isEmpty, let image = profileResetView.profileImageView.snapshotView(afterScreenUpdates: true) else {
            // 필수 입력값이 모두 입력되었는지 확인
            let alert = UIAlertController(title: "입력 오류", message: "닉네임과 프로필 사진은 필수 입력사항입니다. ", preferredStyle: .alert)
            let ok = UIAlertAction(title: "확인", style: .default)
            alert.addAction(ok)
            present(alert, animated: true)
            return
        }
        
        
        
        // 선택된 이미지 및 닉네임을 MyPageMainViewController에 업데이트
        if let mainVC = navigationController?.viewControllers.first(where: {$0 is MyPageMainViewController}) as? MyPageMainViewController {
//            mainVC.updateProfileImage(image: image)
            mainVC.updateProfileNickname(nickname: nickname)
        }
        
        dismiss(animated: true)
    }
}

