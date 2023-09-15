//
//  GameSegmentControll.swift
//  HeartHub
//
//  Created by 제민우 on 2023/08/05.
//

import UIKit

class GameSegmentControll: UISegmentedControl {
    private let underLine = UIView()
    private let normalColor: UIColor
    private let selectedColor: UIColor
    private let font: UIFont
    
    init(
        items: [Any]?,
        normalColor: UIColor,
        selectedColor: UIColor,
        font: UIFont = UIFont(name: "DungGeunMo", size: 20)!
    ) {
        self.normalColor = normalColor
        self.selectedColor = selectedColor
        self.font = font
        super.init(items: items)
        removeInitialImage()
        setupInitialStatus()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        setupTitleAttributes()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let originX = frame.width / CGFloat(numberOfSegments) * CGFloat(selectedSegmentIndex)
        
        UIView.animate(withDuration: 0.1) {
            self.underLine.frame.origin.x = originX
        }
    }
}

// MARK: Configure SegmentedControl
extension GameSegmentControll {
    private func setupTitleAttributes() {
        setTitleTextAttributes([.foregroundColor: normalColor, .font: font], for: .normal)
        setTitleTextAttributes([.foregroundColor: selectedColor, .font: font], for: .selected)
        setBackgroundImage(UIImage(named: "GameSementUnSelectedBackground"), for: .normal, barMetrics: .default)
        setBackgroundImage(UIImage(), for: .selected, barMetrics: .default)
    }
    
    private func setupInitialStatus() {
        selectedSegmentIndex = 0
    }
    
    private func removeInitialImage() {
        setBackgroundImage(
            UIImage(),
            for: .normal,
            barMetrics: .default
        )
        setDividerImage(
            UIImage(),
            forLeftSegmentState: .normal,
            rightSegmentState: .normal,
            barMetrics: .default
        )
    }
}
