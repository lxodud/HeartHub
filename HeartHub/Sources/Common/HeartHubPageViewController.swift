//
//  HeartHubPageViewController.swift
//  HeartHub
//
//  Created by 이태영 on 2023/08/01.
//

import UIKit

final class HeartHubPageViewController: UIViewController {
    private let communityPageViewController = UIPageViewController(
        transitionStyle: .scroll,
        navigationOrientation: .horizontal
    )
    
    private let communitySegmentedControl: HeartHubSegmentedControl = {
        let segmentedControl = HeartHubSegmentedControl(
            items: ["Daily", "Look", "Date"],
            normalColor: UIColor(red: 0.463, green: 0.463, blue: 0.463, alpha: 1),
            selectedColor: UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        )
        return segmentedControl
    }()
    
    private let viewControllers: [UIViewController]
    
    private var currentIndex: Int = 0 {
        didSet {
            let nextViewController = viewControllers[currentIndex]
            let direction: UIPageViewController.NavigationDirection = oldValue < currentIndex ? .forward : .reverse
            communityPageViewController.setViewControllers(
                [nextViewController],
                direction: direction,
                animated: true
            )
        }
    }
    
    init?(viewControllers: [UIViewController]) {
        guard viewControllers.count == 3 else {
            fatalError("ViewControllers count must be three")
        }
        
        self.viewControllers = viewControllers
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Life Cycle
extension HeartHubPageViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCommunitySegmentedControlInitialSetting()
        configureCommunitySegmentedControlLayout()
        configurePageViewControllerInitialSetting()
        configurePageViewControllerLayout()
    }
}

// MARK: PageViewController Delegate Implementation
extension HeartHubPageViewController: UIPageViewControllerDelegate {
    func pageViewController(
        _ pageViewController: UIPageViewController,
        willTransitionTo pendingViewControllers: [UIViewController]
    ) {
        guard let nextViewController = pendingViewControllers.first,
              let index = viewControllers.firstIndex(of: nextViewController)
        else {
            return
        }
        
        communitySegmentedControl.selectedSegmentIndex = index
    }
    
    func pageViewController(
        _ pageViewController: UIPageViewController,
        didFinishAnimating finished: Bool,
        previousViewControllers: [UIViewController],
        transitionCompleted completed: Bool
    ) {
        guard let currentViewController = pageViewController.viewControllers?.first,
              let index = viewControllers.firstIndex(of: currentViewController)
        else {
            return
        }
        
        communitySegmentedControl.selectedSegmentIndex = index
    }
}

// MARK: PageViewController DataSource Implementation
extension HeartHubPageViewController: UIPageViewControllerDataSource {
    func pageViewController(
        _ pageViewController: UIPageViewController,
        viewControllerBefore viewController: UIViewController
    ) -> UIViewController? {
        guard let index = viewControllers.firstIndex(of: viewController),
              (index - 1) >= 0
        else {
            return nil
        }
        
        return viewControllers[index - 1]
    }
    
    func pageViewController(
        _ pageViewController: UIPageViewController,
        viewControllerAfter viewController: UIViewController
    ) -> UIViewController? {
        guard let index = viewControllers.firstIndex(of: viewController),
              (index + 1) != viewControllers.count
        else {
            return nil
        }
        
        return viewControllers[index + 1]
    }
}

// MARK: Configure PageViewController
extension HeartHubPageViewController {
    private func configurePageViewControllerInitialSetting() {
        if let firstViewController = viewControllers.first {
            communityPageViewController.setViewControllers(
                [firstViewController],
                direction: .reverse,
                animated: true
            )
        }
        
        communityPageViewController.dataSource = self
        communityPageViewController.delegate = self
    }
    
    private func configurePageViewControllerLayout() {
        let safeArea = view.safeAreaLayoutGuide
        
        guard let pageView = communityPageViewController.view else {
            return
        }
        
        view.addSubview(pageView)
        
        pageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            pageView.topAnchor.constraint(
                equalTo: communitySegmentedControl.bottomAnchor
            ),
            pageView.leadingAnchor.constraint(
                equalTo: safeArea.leadingAnchor,
                constant: -1
            ),
            pageView.trailingAnchor.constraint(
                equalTo: safeArea.trailingAnchor
            ),
            pageView.bottomAnchor.constraint(
                equalTo: safeArea.bottomAnchor
            ),
        ])
    }
}

// MARK: Configure CommunitySegmentedControl
extension HeartHubPageViewController {
    @objc
    private func tapCommunitySegmentedControl(_ sender: UISegmentedControl) {
        currentIndex = sender.selectedSegmentIndex
    }
    
    private func configureCommunitySegmentedControlInitialSetting() {
        view.addSubview(communitySegmentedControl)
        communitySegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        communitySegmentedControl.addTarget(
            self,
            action: #selector(tapCommunitySegmentedControl(_:)),
            for: .valueChanged
        )
    }
    
    private func configureCommunitySegmentedControlLayout() {
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            communitySegmentedControl.topAnchor.constraint(
                equalTo: safeArea.topAnchor
            ),
            communitySegmentedControl.leadingAnchor.constraint(
                equalTo: safeArea.leadingAnchor
            ),
            communitySegmentedControl.trailingAnchor.constraint(
                equalTo: safeArea.trailingAnchor
            ),
            communitySegmentedControl.heightAnchor.constraint(
                equalTo: safeArea.heightAnchor, multiplier: 0.08
            )
        ])
    }
}
