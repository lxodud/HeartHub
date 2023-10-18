//
//  TermDetailView.swift
//  HeartHub
//
//  Created by 이태영 on 2023/10/18.
//

import UIKit

final class TermDetailView: UIView {
    private let scrollView = UIScrollView()
    private let termLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    // MARK: initializer
    init(termText: String) {
        termLabel.text = termText
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Configure UI
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
            scrollView.leadingAnchor.constraint(
                equalTo: safeArea.leadingAnchor
            ),
            scrollView.trailingAnchor.constraint(
                equalTo: safeArea.trailingAnchor
            ),
            scrollView.bottomAnchor.constraint(
                equalTo: safeArea.bottomAnchor
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
