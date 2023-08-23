//
//  AlertSettingViewController.swift
//  HeartHub
//
//  Created by 전제윤 on 2023/08/19.
//

import UIKit

final class AlertSettingViewController: UIViewController {
    
    private let alertSettingView = AlertSettingView()
    
    override func loadView() {
        view = alertSettingView
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    
}

