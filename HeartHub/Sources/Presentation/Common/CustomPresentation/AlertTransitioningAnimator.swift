//
//  AlertTransitioningAnimator.swift
//  HeartHub
//
//  Created by 이태영 on 2023/09/14.
//

import UIKit

final class AlertTransitioningAnimator: NSObject {
    enum TransitionStyle {
        case presentation
        case dismissal
    }
    
    private let transitionStyle: TransitionStyle
    private let duration: TimeInterval = 1
    
    init(transitionStyle: TransitionStyle) {
        self.transitionStyle = transitionStyle
    }
}

// MARK: - Transitioning Animate Implementation
extension AlertTransitioningAnimator {
    private func animatePresentation(
        transitionContext: UIViewControllerContextTransitioning
    ) {
        guard let fromViewController = transitionContext.viewController(forKey: .from)
        else {
            return
        }
        
        let containerView = transitionContext.containerView
        
        
        guard let presentedView = fromViewController.presentedViewController?.view else {
            return
        }
        
        presentedView.center = containerView.center
        presentedView.transform = CGAffineTransform(scaleX: 1.15, y: 1.15)
        presentedView.alpha = 0
        
        UIView.animate(
            withDuration: 0.4,
            delay: 0,
            usingSpringWithDamping: 0.8,
            initialSpringVelocity: 0,
            animations: {
                presentedView.transform = .identity
                presentedView.alpha = 1
            },
            completion: { complete in
                transitionContext.completeTransition(true)
            })
    }
    
    private func animateDismissal(
        transitionContext: UIViewControllerContextTransitioning
    ) {
        guard let toViewController = transitionContext.viewController(forKey: .to),
              let presentedView = toViewController.presentedViewController?.view
        else {
            return
        }
        
        UIView.animate(
            withDuration: 0.5,
            delay: 0,
            usingSpringWithDamping: 0.8,
            initialSpringVelocity: 0,
            animations: {
                presentedView.alpha = 0
            },
            completion: { complete in
                transitionContext.completeTransition(true)
            })
    }
}

// MARK: - UIViewController Animated Transitioning Implementation
extension AlertTransitioningAnimator: UIViewControllerAnimatedTransitioning {
    func transitionDuration(
        using transitionContext: UIViewControllerContextTransitioning?
    ) -> TimeInterval {
        return duration
    }
    
    func animateTransition(
        using transitionContext: UIViewControllerContextTransitioning
    ) {
        switch transitionStyle {
        case .presentation:
            animatePresentation(transitionContext: transitionContext)
        case .dismissal:
            animateDismissal(transitionContext: transitionContext)
        }
    }
}
