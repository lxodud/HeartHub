//
//  AlertPresentaionController.swift
//  HeartHub
//
//  Created by 이태영 on 2023/09/14.
//

import UIKit

final class AlertPresentationController: UIPresentationController {
    private let dimmingView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.alpha = 0.3
        return view
    }()
    
    override func presentationTransitionWillBegin() {
        guard let containerView = containerView else {
            return
        }
        presentingViewController.beginAppearanceTransition(false, animated: false)
        configureSubview(to: containerView)
        configureLayout(to: containerView)
    }
    
    override func presentationTransitionDidEnd(_ completed: Bool) {
        presentingViewController.endAppearanceTransition()
    }
    
    override func dismissalTransitionWillBegin() {
        presentingViewController.beginAppearanceTransition(true, animated: true)
        dimmingView.removeFromSuperview()
    }
    
    override func dismissalTransitionDidEnd(_ completed: Bool) {
        presentingViewController.endAppearanceTransition()
    }
}


// MARK: - Configure UI
extension AlertPresentationController {
    private func configureSubview(to containerView: UIView) {
        guard let presentedView = presentedView else {
            return
        }
        
        [dimmingView, presentedView].forEach {
            containerView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    private func configureLayout(to containerView: UIView) {
        guard let presentedView = presentedView else {
            return
        }
        
        let safeArea = containerView.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            // MARK: - dimmingView Constraints
            dimmingView.topAnchor.constraint(
                equalTo: containerView.topAnchor
            ),
            dimmingView.trailingAnchor.constraint(
                equalTo: safeArea.trailingAnchor
            ),
            dimmingView.leadingAnchor.constraint(
                equalTo: safeArea.leadingAnchor
            ),
            dimmingView.bottomAnchor.constraint(
                equalTo: containerView.bottomAnchor
            ),
            
            // MARK: - presentedView Constraints
            presentedView.centerXAnchor.constraint(
                equalTo: containerView.centerXAnchor
            ),
            presentedView.centerYAnchor.constraint(
                equalTo: containerView.centerYAnchor
            ),
        ])
    }
}
