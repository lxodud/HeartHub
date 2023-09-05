//
//  MyPageCell.swift
//  HeartHub
//
//  Created by 이태영 on 2023/09/03.
//

import UIKit

final class MyPageCell: UITableViewCell {
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Pretendard-Medium", size: 20)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureSubview()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Configure UI
extension MyPageCell {
    private func configureSubview() {
        [titleLabel].forEach {
            contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    private func configureLayout() {
        let safeArea = contentView.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            // MARK: - titleLabel Constraints
            titleLabel.leadingAnchor.constraint(
                equalTo: safeArea.leadingAnchor,
                constant: 40
            ),
            titleLabel.centerYAnchor.constraint(
                equalTo: safeArea.centerYAnchor
            )
        ])
    }
}
