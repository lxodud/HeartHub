//
//  SignUpDateFormatter.swift
//  HeartHub
//
//  Created by 이태영 on 2023/09/24.
//

import Foundation

final class HeartHubDateFormatter {
    static let shared = HeartHubDateFormatter()
    
    private init() { }
    
    private let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        
        return dateFormatter
    }()
    
    func stringForPresentation(from date: Date) -> String {
        dateFormatter.dateFormat = "yyyy년 MM월 dd일"
        return dateFormatter.string(from: date)
    }
    
    func stringForRequest(from date: Date) -> String {
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: date)
    }
    
    func stringForDday(from date: Date) -> String {
        let calendar = Calendar.current
        let currentDate = Date()
        
        let startDateComponents = calendar.dateComponents([.year, .month, .day], from: date)
        let currentDateComponents = calendar.dateComponents([.year, .month, .day], from: currentDate)
        
        guard let startDate = calendar.date(from: startDateComponents),
              let endDate = calendar.date(from: currentDateComponents)
        else {
            return "D + 0"
        }
        
        let components = calendar.dateComponents([.day], from: startDate, to: endDate)
        let day = components.day ?? 0
        
        return "D + \(day)"
    }
}
