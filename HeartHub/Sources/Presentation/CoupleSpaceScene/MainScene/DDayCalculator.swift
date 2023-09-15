//
//  DDayCalculator.swift
//  HeartHub
//
//  Created by 제민우 on 2023/08/14.
//

import UIKit

final class DDayCalculator {
    
    // 서버에서 getDatingDate 가져와서 저장
    private let startDateString: String = "2022-07-03"
    
    private let dateFormatter: DateFormatter = {
       let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    private func calculateDDay(startDate: Date) -> Int {
        let calendar = Calendar.current
        let currentDate = Date()
        
        let startDateComponents = calendar.dateComponents([.year, .month, .day], from: startDate)
        let currentDateComponents = calendar.dateComponents([.year, .month, .day], from: currentDate)
        
        guard let startDate = calendar.date(from: startDateComponents),
              let endDate = calendar.date(from: currentDateComponents)
        else {
            return 0
        }
        
        let components = calendar.dateComponents([.day], from: startDate, to: endDate)
        return components.day ?? 0
    }
    
    func calculateAndDisplayDDay(dayLabel: UILabel) {
        if let startDate = dateFormatter.date(from: startDateString) {
            let dDay = calculateDDay(startDate: startDate)
            
            dayLabel.text = "D + \(dDay)"
        }
    }
}
