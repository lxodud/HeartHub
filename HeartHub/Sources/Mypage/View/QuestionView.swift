//
//  QuestionView.swift
//  HeartHub
//
//  Created by 전제윤 on 2023/08/23.
//

import UIKit

final class QuestionView: UIView {
    
    private var questionLabel: UILabel = {
        let label = UILabel()
        label.text = "곧 여러분께 좋은 서비스로 찾아 뵙겠습니다. "
        label.textAlignment = .center
        label.font = UIFont(name: "Pretendard-SemiBold", size: 16)
        label.textColor = .black
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - 뷰 추가 및 제약
    
    private func addViews() {
        [questionLabel].forEach{ addSubview($0)}
    }
    
    private func setConstraints() {
        questionLabelConstraints()
    }
    
    private func questionLabelConstraints() {
        questionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            questionLabel.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            questionLabel.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor),
        ])
    }
    
    
    
    
}
