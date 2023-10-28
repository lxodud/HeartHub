//
//  CoupleSpaceMainHeaderView.swift
//  HeartHub
//
//  Created by 이태영 on 2023/08/01.
//

import UIKit

final class CoupleSpaceMainHeaderView: UIView {
    private let coupleImageBetweenHeartView = CoupleImageBetweenHeartView()
        
    private let dayLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Pretendard-SemiBold", size: 28)
        label.textColor = .black
        return label
    }()
    
    private let separateView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        return view
    }()
    
    init() {
        super.init(frame: .zero)
        configureInitialSetting()
        configureSubview()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Configure UI
extension CoupleSpaceMainHeaderView {
    private func configureInitialSetting() {
        backgroundColor = UIColor(red: 0.984, green: 0.937, blue: 0.988, alpha: 0.8)
        layer.cornerRadius = 20
        clipsToBounds = true
        
        let dDayCalculator = DDayCalculator()
        dDayCalculator.calculateAndDisplayDDay(dayLabel: dayLabel)
    }
    
    private func configureSubview() {
        separateView.addSubview(dayLabel)
        dayLabel.translatesAutoresizingMaskIntoConstraints = false
        
        [separateView, coupleImageBetweenHeartView].forEach {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    private func configureLayout() {
        let safeArea = safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            // MARK: dayLabel Constraints
            dayLabel.centerXAnchor.constraint(
                equalTo: separateView.centerXAnchor
            ),
            dayLabel.centerYAnchor.constraint(
                equalTo: separateView.centerYAnchor
            ),
            
            // MARK: separateView Constraints
            separateView.topAnchor.constraint(
                equalTo: safeArea.topAnchor
            ),
            separateView.leadingAnchor.constraint(
                equalTo: safeArea.leadingAnchor
            ),
            separateView.trailingAnchor.constraint(
                equalTo: safeArea.trailingAnchor
            ),
            separateView.heightAnchor.constraint(
                equalTo: safeArea.heightAnchor,
                multiplier: 1/3
            ),
            
            // MARK: coupleImageBetweenHeartView Constraints
            coupleImageBetweenHeartView.topAnchor.constraint(
                equalTo: separateView.bottomAnchor
            ),
            coupleImageBetweenHeartView.leadingAnchor.constraint(
                equalTo: safeArea.leadingAnchor,
                constant: 40
            ),
            coupleImageBetweenHeartView.trailingAnchor.constraint(
                equalTo: safeArea.trailingAnchor,
                constant: -40
            ),
            coupleImageBetweenHeartView.heightAnchor.constraint(
                equalTo: safeArea.heightAnchor,
                multiplier: 2/3
            ),
            
        ])
    }
}
