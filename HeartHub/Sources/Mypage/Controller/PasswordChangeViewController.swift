//
//  PasswordChangeViewController.swift
//  HeartHub
//
//  Created by 전제윤 on 2023/08/19.
//

import UIKit

class PasswordChangeViewController: UIViewController {
    
    private let passwordChangeView = PasswordChangeView()
    
    override func loadView() {
        view = passwordChangeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
}
