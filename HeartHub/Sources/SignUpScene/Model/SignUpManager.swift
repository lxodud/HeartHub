//
//  SignUpManager.swift
//  HeartHub
//
//  Created by 이태영 on 2023/08/17.
//

import Foundation

final class SignUpManager {
    var userID: String?
    var password: String?
    var gender: String?
    var email: String?
    var nickname: String?
    var marketingStatus: Bool?
    var datingDate: String?
    var birth: String?
    var basicProfileImage: Data?
    
    private var marketingStatusString: String {
        marketingStatus ?? false ? "T" : "F"
    }
    
    private var emailCertificationNumber: Int?
    private let networkManager: NetworkManager = DefaultNetworkManager()
    private let decoder = JSONDecoder()
    
    private func decode<T: Decodable>(from data: Data) throws -> T {
        return try decoder.decode(T.self, from: data)
    }
    
    private func convertDateFormForJoin(with date: String?) -> String? {
        guard let date = date else {
            return nil
        }
        
        var convertedDate = date.replacingOccurrences(of: "년 ", with: "-")
        convertedDate = convertedDate.replacingOccurrences(of: "월 ", with: "-")
        convertedDate = convertedDate.replacingOccurrences(of: "일", with: "")
        
        return convertedDate
    }
    
    private func convertUserInformationForJoin() -> JoinRequestDTO? {
        guard let userID = userID,
              let password = password,
              let gender = gender,
              let email = email,
              let nickname = nickname,
              let datingDate = convertDateFormForJoin(with: datingDate),
              let birth = convertDateFormForJoin(with: birth)
        else {
            return nil
        }
        
        return JoinRequestDTO(
            username: userID,
            password: password,
            gender: gender,
            email: email,
            nickname: nickname,
            marketingStatus: marketingStatusString,
            mate: "",
            datingDate: datingDate,
            birth: birth
        )
    }
}

// MARK: Requst Network
extension SignUpManager {
    func checkIDAvailability(with id: String, completion: @escaping (Bool) -> Void) {
        guard userID != id else {
            return
        }
        
        let request = UserRelatedRequestFactory.makeIdCheckRequest(of: id)
        
        networkManager.request(endpoint: request) { result in
            switch result {
            case .success(let data):
                self.userID = id
                do {
                    let deserializedData: CheckAvailabilityResponseDTO = try self.decode(from: data)
                    completion(deserializedData.data)
                } catch let error {
                    print(error)
                }
                break
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func checkNicknameAvailability(with inputNickname: String, completion: @escaping (Bool) -> Void) {
        guard nickname != inputNickname else {
            return
        }
        
        let request = UserRelatedRequestFactory.makeNicknameCheckRequest(of: inputNickname)
        
        networkManager.request(endpoint: request) { result in
            switch result {
            case .success(let data):
                self.nickname = inputNickname
                do {
                    let deserializedData: CheckAvailabilityResponseDTO = try self.decode(from: data)
                    completion(deserializedData.data)
                } catch let error {
                    print(error)
                }
                break
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func sendVerificationCodeToEmail(with inputEmail: String) {
        guard email != inputEmail else {
            return
        }
        
        let request = UserRelatedRequestFactory.makeVerificateEmailRequest(of: inputEmail)
        
        networkManager.request(endpoint: request) { result in
            switch result {
            case .success(let data):
                do {
                    let deserializedData: EmailVerificationResponseDTO = try self.decode(from: data)
                    self.emailCertificationNumber = Int(deserializedData.data)
                } catch let error {
                    print(error)
                }
                self.email = inputEmail
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func join(completion: @escaping () -> Void) {
        guard let userInformation = convertUserInformationForJoin() else {
            return
        }
        
        let request = UserRelatedRequestFactory.makeJoinRequest(of: userInformation)

        networkManager.request(endpoint: request) { result in
            switch result {
            case .success(_):
                completion()
            case .failure(let error):
                print(error)
            }
        }
    }
}
