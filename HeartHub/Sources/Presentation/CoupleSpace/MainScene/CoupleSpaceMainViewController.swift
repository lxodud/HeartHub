//
//  CoupleSpaceMainViewController.swift
//  HeartHub
//
//  Created by 이태영 on 2023/08/02.
//

import RxCocoa
import RxSwift
import UIKit

final class CoupleSpaceMainViewController: UIViewController {
    private let viewModel: CoupleSpaceMainViewModel
    private let disposeBag = DisposeBag()
    
    private let headerView = CoupleSpaceMainHeaderView()
    private let headerBackgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "CoupleSpaceMainBackground")
        return imageView
    }()
    
    private let buttonBackgroundView: UIView = {
        let view = UIView()
        return view
    }()
    
    private let buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 32
        return stackView
    }()
    
    private let albumButton = CoupleSpaceMainButtonView(
        image: UIImage(named: "AlbumButtonImage"),
        title: "Album"
    )
    
    private let connectButton = CoupleSpaceMainButtonView(
        image: UIImage(named: "ConnectButtonImage"),
        title: "Connect"
    )
    
    // MARK: - initializer
    init(viewModel: CoupleSpaceMainViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        configureSubview()
        configureLayout()
        bind(to: viewModel)
    }
    
    private func bind(to: CoupleSpaceMainViewModel) {
        let viewWillAppear = rx.sentMessage(#selector(UIViewController.viewWillAppear))
            .map { _ in }
            .asDriver(onErrorJustReturn: ())
        
        let albumButtonTapGesture = UITapGestureRecognizer()
        albumButton.addGestureRecognizer(albumButtonTapGesture)

        let connectButtonTapGesture = UITapGestureRecognizer()
        connectButton.addGestureRecognizer(connectButtonTapGesture)
        
        let input = CoupleSpaceMainViewModel.Input(
            viewWillAppear: viewWillAppear,
            albumButtonTap: albumButtonTapGesture.rx.event.map { _ in }.asDriver(onErrorJustReturn: ()),
            connectButtonTap: connectButtonTapGesture.rx.event.map { _ in }.asDriver(onErrorJustReturn: ())
        )
        
        let output = viewModel.transform(input)
        
//        output.isMateExist
//            .map { !$0 }
//            .drive(headerView.coupleImageBetweenHeartView.rx.isHidden)
//            .disposed(by: disposeBag)
        
        output.toAlbum
            .drive()
            .disposed(by: disposeBag)

        output.toConnect
            .drive()
            .disposed(by: disposeBag)
    }
}

// MARK: Configure UI
extension CoupleSpaceMainViewController {
    private func configureSubview() {
        [headerBackgroundImageView, buttonBackgroundView].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        [albumButton, connectButton].forEach {
            buttonStackView.addArrangedSubview($0)
        }
        
        buttonBackgroundView.addSubview(buttonStackView)
        headerBackgroundImageView.addSubview(headerView)
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        headerView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configureLayout() {
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            // MARK: headerBackgroundImageView Constraints
            headerBackgroundImageView.topAnchor.constraint(
                equalTo: view.topAnchor
            ),
            headerBackgroundImageView.leadingAnchor.constraint(
                equalTo: safeArea.leadingAnchor
            ),
            headerBackgroundImageView.trailingAnchor.constraint(
                equalTo: safeArea.trailingAnchor
            ),
            headerBackgroundImageView.heightAnchor.constraint(
                equalTo: safeArea.heightAnchor,
                multiplier: 0.5
            ),
            
            // MARK: headerView Constraints
            headerView.centerXAnchor.constraint(
                equalTo: safeArea.centerXAnchor
            ),
            headerView.topAnchor.constraint(
                equalTo: view.topAnchor,
                constant: 100
            ),
            headerView.heightAnchor.constraint(
                equalTo: headerBackgroundImageView.heightAnchor,
                multiplier: 0.6
            ),
            headerView.widthAnchor.constraint(
                equalTo: headerBackgroundImageView.widthAnchor,
                multiplier: 0.8
            ),
            
            
            // MARK: buttonBackgroundView Constraints
            buttonBackgroundView.topAnchor.constraint(
                equalTo: headerBackgroundImageView.bottomAnchor
            ),
            buttonBackgroundView.leadingAnchor.constraint(
                equalTo: safeArea.leadingAnchor
            ),
            buttonBackgroundView.trailingAnchor.constraint(
                equalTo: safeArea.trailingAnchor
            ),
            buttonBackgroundView.bottomAnchor.constraint(
                equalTo: safeArea.bottomAnchor
            ),
            
            // MARK: buttonStackView Constraints
            buttonStackView.centerXAnchor.constraint(
                equalTo: buttonBackgroundView.centerXAnchor
            ),
            buttonStackView.centerYAnchor.constraint(
                equalTo: buttonBackgroundView.centerYAnchor
            ),
            buttonStackView.heightAnchor.constraint(
                equalTo: buttonBackgroundView.heightAnchor,
                multiplier: 0.65
            ),
            buttonStackView.widthAnchor.constraint(
                equalTo: buttonBackgroundView.widthAnchor,
                multiplier: 0.7
            ),
            
        ])
    }
}
