//
//  SignUpColor.swift
//  HeartHub
//
//  Created by 이태영 on 2023/09/25.
//

import UIKit

enum SignUpColor {
    case red
    case green
    case gray
    
    var uiColor: UIColor {
        switch self {
        case .red:
            return .systemRed
        case .green:
            return .systemGreen
        case .gray:
            return UIColor(red: 0.46, green: 0.46, blue: 0.46, alpha: 1)
        }
    }
}
