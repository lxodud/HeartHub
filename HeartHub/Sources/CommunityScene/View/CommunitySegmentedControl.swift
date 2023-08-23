//
//  CommunitySegmentControl.swift
//  HeartHub
//
//  Created by 이태영 on 2023/07/08.
//

import UIKit

final class CommunitySegmentedControl: UISegmentedControl {
    private let underLine = UIView()
    private let normalColor: UIColor
    private let selectedColor: UIColor
    private let font: UIFont
    
    init(
        items: [Any]?,
        normalColor: UIColor,
        selectedColor: UIColor,
        font: UIFont = UIFont(name: "Pretendard-SemiBold", size: 20)!
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
        configureUnderLineview()
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
extension CommunitySegmentedControl {
    private func setupTitleAttributes() {
        setTitleTextAttributes([.foregroundColor: normalColor, .font: font], for: .normal)
        setTitleTextAttributes([.foregroundColor: selectedColor, .font: font], for: .selected)
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

// MARK: Configure UI
extension CommunitySegmentedControl {
    private func configureUnderLineview() {
        let originX: CGFloat = 0
        let originY: CGFloat = bounds.size.height - 3
        let width: CGFloat = bounds.size.width / CGFloat(numberOfSegments)
        let height: CGFloat = 3
        
        underLine.frame = CGRect(x: originX, y: originY, width: width, height: height)
        
        underLine.backgroundColor = selectedColor
        addSubview(underLine)
    }
}
