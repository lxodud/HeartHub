//
//  QestionLabelViewController.swift
//  HeartHub
//
//  Created by 전제윤 on 2023/08/23.
//

import UIKit

final class QuestionViewController: UIViewController {

    private let questionView = QuestionView()
    
    override func loadView() {
        view = questionView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
}
