//
//  ViewModelType.swift
//  HeartHub
//
//  Created by 이태영 on 2023/09/17.
//

protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    
    func transform(_ input: Input) -> Output
}
