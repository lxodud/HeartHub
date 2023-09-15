//
//  GamePageViewController.swift
//  HeartHub
//
//  Created by 제민우 on 2023/08/05.
//

import UIKit

class GamePageViewController: UIViewController {

    private let gamePageViewController = UIPageViewController(
        transitionStyle: .scroll,
        navigationOrientation: .horizontal
    )
    
    private let gameSegmentedControl: GameSegmentControll = {
        let segmentedControl = GameSegmentControll(
            items: ["미션", "클리어!"],
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
            gamePageViewController.setViewControllers(
                [nextViewController],
                direction: direction,
                animated: true
            )
        }
    }
    
    init?(viewControllers: [UIViewController]) {
        guard viewControllers.count == 2 else {
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
extension GamePageViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        configureGameSegmentedControlInitialSetting()
        configureGameSegmentedControlLayout()
        configureGameViewControllerInitialSetting()
        configurePageViewControllerLayout()
    }
}

// MARK: PageViewController Delegate Implementation
extension GamePageViewController: UIPageViewControllerDelegate {
    func pageViewController(
        _ pageViewController: UIPageViewController,
        willTransitionTo pendingViewControllers: [UIViewController]
    ) {
        guard let nextViewController = pendingViewControllers.first,
              let index = viewControllers.firstIndex(of: nextViewController)
        else {
            return
        }
        gameSegmentedControl.selectedSegmentIndex = index
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
        gameSegmentedControl.selectedSegmentIndex = index
    }
}

// MARK: PageViewController DataSource Implementation
extension GamePageViewController: UIPageViewControllerDataSource {
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
extension GamePageViewController {
    private func configureGameViewControllerInitialSetting() {
        if let firstViewController = viewControllers.first {
            gamePageViewController.setViewControllers(
                [firstViewController],
                direction: .reverse,
                animated: true
            )
        }
        gamePageViewController.dataSource = self
        gamePageViewController.delegate = self
    }
    
    private func configurePageViewControllerLayout() {
        let safeArea = view.safeAreaLayoutGuide
        
        guard let pageView = gamePageViewController.view else {
            return
        }
        
        view.addSubview(pageView)
        
        pageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            pageView.topAnchor.constraint(
                equalTo: gameSegmentedControl.bottomAnchor
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

// MARK: Configure GameSegmentedControl
extension GamePageViewController {
    @objc
    private func tapGameSegmentedControl(_ sender: UISegmentedControl) {
        currentIndex = sender.selectedSegmentIndex
    }
    
    private func configureGameSegmentedControlInitialSetting() {
        view.addSubview(gameSegmentedControl)
        gameSegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        gameSegmentedControl.addTarget(
            self,
            action: #selector(tapGameSegmentedControl(_:)),
            for: .valueChanged
        )
    }
    
    private func configureGameSegmentedControlLayout() {
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            gameSegmentedControl.topAnchor.constraint(
                equalTo: safeArea.topAnchor
            ),
            gameSegmentedControl.leadingAnchor.constraint(
                equalTo: safeArea.leadingAnchor
            ),
            gameSegmentedControl.trailingAnchor.constraint(
                equalTo: safeArea.trailingAnchor
            ),
            gameSegmentedControl.heightAnchor.constraint(
                equalTo: view.heightAnchor, multiplier: 0.1
            )
        ])
    }
}
