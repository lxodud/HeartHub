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
        guard let containerView = containerView,
              let presentedView = presentedView,
              let transitionCoordinator = presentedViewController.transitionCoordinator
        else {
            return
        }
        
        configureDimming(to: containerView)
        containerView.addSubview(presentedView)
        presentedView.transform = CGAffineTransform(scaleX: 1.15, y: 1.15)
        presentedView.alpha = 0
        
        transitionCoordinator.animate(alongsideTransition: { _ in
            presentedView.transform = .identity
            presentedView.alpha = 1
        })
    }
    
    override func dismissalTransitionWillBegin() {
        guard let transitionCoordinator = presentedViewController.transitionCoordinator,
              let presentedView = presentedView
        else {
            return
        }
        
        transitionCoordinator.animate(alongsideTransition: { _ in
            presentedView.alpha = 0
        }, completion: { _ in
            presentedView.removeFromSuperview()
        })
    }
}


// MARK: Configure UI
extension AlertPresentationController {
    private func configureDimming(to containerView: UIView) {
        containerView.addSubview(dimmingView)
        dimmingView.translatesAutoresizingMaskIntoConstraints = false
        
        let safeArea = containerView.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
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
        ])
    }
}
