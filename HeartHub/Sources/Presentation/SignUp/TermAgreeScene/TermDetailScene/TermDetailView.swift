//
//  TermDetailView.swift
//  HeartHub
//
//  Created by 이태영 on 2023/10/18.
//

import UIKit

final class TermDetailView: UIView {
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isDirectionalLockEnabled = true
        return scrollView
    }()
    private let termLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    // MARK: - initializer
    init(termText: String) {
        termLabel.text = termText
        super.init(frame: .zero)
        scrollView.delegate = self
        configureSubview()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UIScrollViewDelegate Implemenation
extension TermDetailView: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.x != 0 {
            scrollView.contentOffset.x = 0
        }
    }
}

// MARK: - Configure UI
extension TermDetailView {
    private func configureSubview() {
        addSubview(scrollView)
        scrollView.addSubview(termLabel)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        termLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configureLayout() {
        let safeArea = safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            // MARK: scrollView Constraints
            scrollView.topAnchor.constraint(
                equalTo: safeArea.topAnchor
            ),
            scrollView.bottomAnchor.constraint(
                equalTo: safeArea.bottomAnchor
            ),
            scrollView.centerXAnchor.constraint(
                equalTo: safeArea.centerXAnchor
            ),
            scrollView.widthAnchor.constraint(
                equalTo: safeArea.widthAnchor,
                multiplier: 0.95
            ),
            
            // MARK: termLabel Constraints
            termLabel.topAnchor.constraint(
                equalTo: scrollView.contentLayoutGuide.topAnchor
            ),
            termLabel.leadingAnchor.constraint(
                equalTo: scrollView.contentLayoutGuide.leadingAnchor
            ),
            termLabel.trailingAnchor.constraint(
                equalTo: scrollView.contentLayoutGuide.trailingAnchor
            ),
            termLabel.bottomAnchor.constraint(
                equalTo: scrollView.contentLayoutGuide.bottomAnchor
            ),
            termLabel.widthAnchor.constraint(
                equalTo: scrollView.frameLayoutGuide.widthAnchor
            )
        ])
    }
}
