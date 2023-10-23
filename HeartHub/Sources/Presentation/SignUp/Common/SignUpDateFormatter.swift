//
//  SignUpDateFormatter.swift
//  HeartHub
//
//  Created by 이태영 on 2023/09/24.
//

import Foundation

final class SignUpDateFormatter {
    static let shared = SignUpDateFormatter()
    
    private init() { }
    
    private let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        
        return dateFormatter
    }()
    
    func stringForPresentation(from: Date) -> String {
        dateFormatter.dateFormat = "yyyy년 MM월 dd일"
        return dateFormatter.string(from: from)
    }
    
    func stringForRequest(from: Date) -> String {
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: from)
    }
}
