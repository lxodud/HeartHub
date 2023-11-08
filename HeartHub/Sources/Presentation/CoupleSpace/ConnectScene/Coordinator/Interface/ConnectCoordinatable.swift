//
//  ConnectCoordinatable.swift
//  HeartHub
//
//  Created by 이태영 on 2023/11/05.
//

protocol ConnectCoordinatable: Coordinatable {
    func toMateInformation(_ id: String)
    func toSuccessAlert()
}
