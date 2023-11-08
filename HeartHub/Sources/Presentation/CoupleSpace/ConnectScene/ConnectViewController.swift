//
//  ConnectViewController.swift
//  HeartHub
//
//  Created by 이태영 on 2023/11/05.
//

import RxCocoa
import RxSwift
import UIKit

final class ConnectViewController: UIViewController {
    private let viewModel: ConnectViewModel
    private let disposeBag = DisposeBag()
    
    private let mateInputTextField = HeartHubUserInfoInputTextField(
        placeholder: "내 애인의 아이디를 입력하세요",
        keyboardType: .default,
        isSecureTextEntry: false
    )
    
    private let connectButton: UIButton = {
        let button = UIButton(type: .custom)
        button.layer.cornerRadius = 18
 
        button.setTitle("계정 연동하기", for: .normal)
        button.titleLabel?.font = UIFont.init(name: "Pretendard-Regular", size: 14)
        button.titleLabel?.textAlignment = .center
        button.setTitleColor(UIColor(red: 0.067, green: 0.067, blue: 0.067, alpha: 1), for: .normal)
        button.clipsToBounds = true
        
        let normalColor = UIColor(red: 0.98, green: 0.184, blue: 0.741, alpha: 1)
        button.setBackgroundColor(.systemGray4, for: .disabled)
        button.setBackgroundColor(normalColor, for: .normal)
        
        button.layer.shadowColor = UIColor(red: 0.98, green: 0.184, blue: 0.741, alpha: 0.25).cgColor
        button.layer.shadowOpacity = 1.0
        button.layer.shadowOffset = CGSize(width: 0, height: 4)
        button.layer.shadowRadius = 6
        
        return button
    }()
    
    // MARK: - initializer
    init(viewModel: ConnectViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        configureSuperview()
        configureSubview()
        configureLayout()
        bind(to: viewModel)
    }
    
    private func bind(to viewModel: ConnectViewModel) {
        let input = ConnectViewModel.Input(
            id: mateInputTextField.rx.text.orEmpty.asDriver(),
            tapFindMate: connectButton.rx.tap.asDriver()
        )
        
        let output = viewModel.transform(input)
        
        output.isFindMateEnable
            .drive(connectButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        output.toMateInformation
            .drive()
            .disposed(by: disposeBag)
    }
}

// MARK: - Configure UI
extension ConnectViewController {
    private func configureSuperview() {
        view.backgroundColor = .systemBackground
    }
    
    private func configureSubview() {
        [mateInputTextField, connectButton].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    private func configureLayout() {
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            // MARK: mateInputTextField Constraints
            mateInputTextField.centerXAnchor.constraint(
                equalTo: safeArea.centerXAnchor
            ),
            mateInputTextField.centerYAnchor.constraint(
                equalTo: safeArea.centerYAnchor,
                constant: -(view.bounds.height * 0.1)
            ),
            mateInputTextField.widthAnchor.constraint(
                equalTo: safeArea.widthAnchor,
                multiplier: 0.8
            ),
            
            // MARK: connectButton Constraints
            connectButton.bottomAnchor.constraint(
                equalTo: safeArea.bottomAnchor,
                constant: -30
            ),
            connectButton.centerXAnchor.constraint(
                equalTo: safeArea.centerXAnchor
            ),
            connectButton.widthAnchor.constraint(
                equalTo: safeArea.widthAnchor,
                multiplier: 0.8
            ),
            connectButton.heightAnchor.constraint(
                equalToConstant: 60
            )
        ])
    }
}

let mateProfileImage = UIImage(named: "mateProfile")!.pngData()!
