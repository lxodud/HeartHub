//
//  ProfileModifyViewModel.swift
//  HeartHub
//
//  Created by 이태영 on 2023/09/11.
//

import Foundation

final class ProfileModifyViewModel {
    private let myInformationService: MyInformationService
    private let nicknameService: NicknameService
    
    private var nickname: String?
    private var profileImage: Data? {
        didSet {
            profileImageHandler?(profileImage)
        }
    }
    
    private var canModify: Bool = false {
        didSet {
            canModifyHandler?(canModify)
        }
    }
    
    var profileImageHandler: ((Data?) -> Void)?
    var canModifyHandler: ((Bool) -> Void)?
    
    init(
        myInformationService: MyInformationService = MyInformationService(),
        nicknameService: NicknameService = NicknameService()
    ) {
        self.myInformationService = myInformationService
        self.nicknameService = nicknameService
    }
    
    func fetchProfileImage() {
        profileImage = myInformationService.fetchProfileImage()
    }
    
    func modifyProfile(with nickname: String?, completion: @escaping (String) -> Void) {
        guard let nickname = nickname,
              let profileImage = profileImage,
              self.nickname != nickname
        else {
            completion("변경사항이 없습니다.")
            return
        }
        
        self.nickname = nickname
        nicknameService.checkNicknameAvailability(with: nickname) { canModify in
            if canModify {
                self.myInformationService.editMyInformation(
                    imageData: profileImage,
                    nickname: nickname
                ) { result in
                    switch result {
                    case .success(_):
                        completion("프로필 수정 완료되었습니다.")
                    case .failure(_):
                        completion("프로필 수정 실패했습니다.")
                    }
                }
                
            } else {
                completion("중복된 닉네임입니다.")
            }
        }
    }
    
    func changeModifyState(_ state: Bool) {
        canModify = state
    }
}

extension ProfileModifyViewModel: HeartHubImagePickerDelegate {
    func passSelectedImage(_ image: Data) {
        profileImage = image
    }
}
