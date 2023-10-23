//
//  TermAgreeViewController.swift
//  HeartHub
//
//  Created by 이태영 on 2023/10/10.
//

import RxCocoa
import RxSwift
import UIKit

final class TermAgreeViewController: UIViewController {
    private let viewModel: TermAgreeViewModel
    private let disposeBag = DisposeBag()
    
    private let titleLabel = SignUpTitleLabelStackView(
        title: "사랑을 시작해볼까요?",
        description: "계정을 생성하여 HeartHub를 즐겨보아요."
    )
    private let allAgreeCheckBox = TermAgreeCheckBoxStackView(
        description: "약관 전체 동의"
    )
    private let seperateView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray3
        return view
    }()
    
    private let ageTermCheckBox = TermAgreeCheckBoxStackView(
        description: "(필수) 만 14세 이상입니다."
    )
    private let ageTermDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "HeartHuB 서비스를 이용하기 위해서는 만 14세 이상이 되어야 합니다. 만 14세 미만의 이용자일 경우 이용이 제한됩니다."
        label.numberOfLines = 0
        label.font = UIFont(name: "Pretendard-Regular", size: 12)
        return label
    }()
    
    private let personalInformationCollectionAndUsageCheckBox = TermAgreeCheckBoxStackView(
        description: "(필수) 개인정보 수집 및 이용동의"
    )
    private let personalInformationCollectionAndUsageDisclosureIndicator: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "SignUpDisclosureIndicator")
        return imageView
    }()
    
    private let termsOfUseCheckBox = TermAgreeCheckBoxStackView(
        description: "(필수) 이용 약관 동의"
    )
    private let termsOfUseDisclosureIndicator: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "SignUpDisclosureIndicator")
        return imageView
    }()
    
    private let marketingConsentCheckBox = TermAgreeCheckBoxStackView(
        description: "(선택) 마케팅 활용 동의"
    )
    private let marketingConsentDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "개인정보의 마케팅 활용(마케팅 및 광고성 정보 전송)에 동의하지 않으실 수 있으며, 동의하지 않으시더라도 HeartHuB 서비스를 이용하실 수 있습니다."
        label.numberOfLines = 0
        label.font = UIFont(name: "Pretendard-Regular", size: 12)
        return label
    }()
    
    private let signUpButton: UIButton = SignUpBottomButton(title: "계정 생성하기")
    
    private let activityIndicator = UIActivityIndicatorView()
    
    // MARK: - initializer
    init(viewModel: TermAgreeViewModel) {
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
    
    private func bind(to viewModel: TermAgreeViewModel) {
        let personalInformationCollectionAndUsageDetailTapGesture = UITapGestureRecognizer()
        let termsOfUseDetailTapGesture = UITapGestureRecognizer()
        personalInformationCollectionAndUsageCheckBox.addGestureRecognizer(
            personalInformationCollectionAndUsageDetailTapGesture
        )
        termsOfUseCheckBox.addGestureRecognizer(termsOfUseDetailTapGesture)
        
        let tapPersonalInformationCollectionAndUsageDetail = personalInformationCollectionAndUsageDetailTapGesture
            .rx.event.map { _ in }.asDriver(onErrorJustReturn: ())
        
        let tapTermsOfUseDetail = termsOfUseDetailTapGesture
            .rx.event.map { _ in }.asDriver(onErrorJustReturn: ())
        
        let input = TermAgreeViewModel.Input(
            tapAllAgree: allAgreeCheckBox.checkButton.rx.tap.asDriver(),
            tapAgeTerm: ageTermCheckBox.checkButton.rx.tap.asDriver(),
            tapPersonalInformationCollectionAndUsage: personalInformationCollectionAndUsageCheckBox
                .checkButton.rx.tap.asDriver(),
            tapTermsOfUse: termsOfUseCheckBox.checkButton.rx.tap.asDriver(),
            tapMarketingConsent: marketingConsentCheckBox.checkButton.rx.tap.asDriver(),
            tapPersonalInformationCollectionAndUsageDetail: tapPersonalInformationCollectionAndUsageDetail,
            tapTermsOfUseDetail: tapTermsOfUseDetail,
            tapSignUp: signUpButton.rx.tap.asDriver()
        )
        
        let output = viewModel.transform(input)
        
        output.isAllAgreeSelected
            .drive(allAgreeCheckBox.checkButton.rx.isSelected)
            .disposed(by: disposeBag)
        
        output.isAgeTermSelected
            .drive(ageTermCheckBox.checkButton.rx.isSelected)
            .disposed(by: disposeBag)
        
        output.isPersonalInformationCollectionAndUsageSelected
            .drive(personalInformationCollectionAndUsageCheckBox.checkButton.rx.isSelected)
            .disposed(by: disposeBag)
        
        output.isTermsOfUse
            .drive(termsOfUseCheckBox.checkButton.rx.isSelected)
            .disposed(by: disposeBag)
        
        output.isMarketingConsent
            .drive(marketingConsentCheckBox.checkButton.rx.isSelected)
            .disposed(by: disposeBag)
        
        output.toPersonalInformationCollectionAndUsageDetail
            .drive()
            .disposed(by: disposeBag)
        
        output.toTermsOfUseDetail
            .drive()
            .disposed(by: disposeBag)
        
        output.isSignUpEnable
            .drive(signUpButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        output.signingUp
            .drive(activityIndicator.rx.isAnimating)
            .disposed(by: disposeBag)
        
        output.signedUp
            .drive()
            .disposed(by: disposeBag)
    }
}

// MARK: - Configure UI
extension TermAgreeViewController {
    private func configureSuperview() {
        view.backgroundColor = .systemBackground
    }
    
    private func configureSubview() {
        [titleLabel,
         allAgreeCheckBox,
         seperateView,
         ageTermCheckBox,
         ageTermDescriptionLabel,
         personalInformationCollectionAndUsageCheckBox,
         personalInformationCollectionAndUsageDisclosureIndicator,
         termsOfUseCheckBox,
         termsOfUseDisclosureIndicator,
         marketingConsentCheckBox,
         marketingConsentDescriptionLabel,
         signUpButton,
         activityIndicator].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    private func configureLayout() {
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            // MARK: - titleLabel Constraints
            titleLabel.centerYAnchor.constraint(
                equalTo: safeArea.centerYAnchor,
                constant: -(view.bounds.height * 0.35)
            ),
            titleLabel.centerXAnchor.constraint(
                equalTo: safeArea.centerXAnchor
            ),
            titleLabel.widthAnchor.constraint(
                equalTo: safeArea.widthAnchor,
                multiplier: 0.8
            ),
            
            // MARK: - allAgreeCheckBox Constraints
            allAgreeCheckBox.topAnchor.constraint(
                equalTo: titleLabel.bottomAnchor,
                constant: 30
            ),
            allAgreeCheckBox.centerXAnchor.constraint(
                equalTo: safeArea.centerXAnchor
            ),
            allAgreeCheckBox.widthAnchor.constraint(
                equalTo: safeArea.widthAnchor,
                multiplier: 0.8
            ),
            
            // MARK: - seperateView Constraints
            seperateView.topAnchor.constraint(
                equalTo: allAgreeCheckBox.bottomAnchor,
                constant: 10
            ),
            seperateView.centerXAnchor.constraint(
                equalTo: safeArea.centerXAnchor
            ),
            seperateView.widthAnchor.constraint(
                equalTo: safeArea.widthAnchor,
                multiplier: 0.9
            ),
            seperateView.heightAnchor.constraint(
                equalToConstant: 1
            ),
            
            // MARK: ageTermCheckBox Constraints
            ageTermCheckBox.topAnchor.constraint(
                equalTo: seperateView.bottomAnchor,
                constant: 20
            ),
            ageTermCheckBox.centerXAnchor.constraint(
                equalTo: safeArea.centerXAnchor
            ),
            ageTermCheckBox.widthAnchor.constraint(
                equalTo: allAgreeCheckBox.widthAnchor
            ),
            
            // MARK: ageTermDescriptionLabel Constraints
            ageTermDescriptionLabel.topAnchor.constraint(
                equalTo: ageTermCheckBox.bottomAnchor,
                constant: 5
            ),
            ageTermDescriptionLabel.leadingAnchor.constraint(
                equalTo: ageTermCheckBox.descriptionLabel.leadingAnchor
            ),
            ageTermDescriptionLabel.trailingAnchor.constraint(
                equalTo: ageTermCheckBox.descriptionLabel.trailingAnchor
            ),
            
            // MARK: personalInformationCollectionAndUsageCheckBox Constraints
            personalInformationCollectionAndUsageCheckBox.topAnchor.constraint(
                equalTo: ageTermDescriptionLabel.bottomAnchor,
                constant: 8
            ),
            personalInformationCollectionAndUsageCheckBox.centerXAnchor.constraint(
                equalTo: safeArea.centerXAnchor
            ),
            personalInformationCollectionAndUsageCheckBox.widthAnchor.constraint(
                equalTo: ageTermCheckBox.widthAnchor
            ),
            
            // MARK: personalInformationCollectionAndUsageDisclosureIndicator Constraints
            personalInformationCollectionAndUsageDisclosureIndicator.topAnchor.constraint(
                equalTo: personalInformationCollectionAndUsageCheckBox.topAnchor
            ),
            personalInformationCollectionAndUsageDisclosureIndicator.trailingAnchor.constraint(
                equalTo: personalInformationCollectionAndUsageCheckBox.trailingAnchor
            ),
            personalInformationCollectionAndUsageDisclosureIndicator.bottomAnchor.constraint(
                equalTo: personalInformationCollectionAndUsageCheckBox.bottomAnchor
            ),
            
            // MARK: termsOfUseCheckBox Constraints
            termsOfUseCheckBox.topAnchor.constraint(
                equalTo: personalInformationCollectionAndUsageCheckBox.bottomAnchor,
                constant: 8
            ),
            termsOfUseCheckBox.centerXAnchor.constraint(
                equalTo: safeArea.centerXAnchor
            ),
            termsOfUseCheckBox.widthAnchor.constraint(
                equalTo: personalInformationCollectionAndUsageCheckBox.widthAnchor
            ),
            
            // MARK: termsOfUseDisclosureIndicator Constraints
            termsOfUseDisclosureIndicator.topAnchor.constraint(
                equalTo: termsOfUseCheckBox.topAnchor
            ),
            termsOfUseDisclosureIndicator.trailingAnchor.constraint(
                equalTo: termsOfUseCheckBox.trailingAnchor
            ),
            termsOfUseDisclosureIndicator.bottomAnchor.constraint(
                equalTo: termsOfUseCheckBox.bottomAnchor
            ),
            
            // MARK: marketingConsentCheckBox Constraints
            marketingConsentCheckBox.topAnchor.constraint(
                equalTo: termsOfUseCheckBox.bottomAnchor,
                constant: 8
            ),
            marketingConsentCheckBox.centerXAnchor.constraint(
                equalTo: safeArea.centerXAnchor
            ),
            marketingConsentCheckBox.widthAnchor.constraint(
                equalTo: termsOfUseCheckBox.widthAnchor
            ),

            // MARK: marketingConsentDescriptionLabel Constraints
            marketingConsentDescriptionLabel.topAnchor.constraint(
                equalTo: marketingConsentCheckBox.bottomAnchor,
                constant: 5
            ),
            marketingConsentDescriptionLabel.leadingAnchor.constraint(
                equalTo: marketingConsentCheckBox.descriptionLabel.leadingAnchor
            ),
            marketingConsentDescriptionLabel.trailingAnchor.constraint(
                equalTo: marketingConsentCheckBox.descriptionLabel.trailingAnchor
            ),
            
            // MARK: - createAccountButton Constraints
            signUpButton.bottomAnchor.constraint(
                equalTo: safeArea.bottomAnchor,
                constant: -30
            ),
            signUpButton.centerXAnchor.constraint(
                equalTo: safeArea.centerXAnchor
            ),
            signUpButton.widthAnchor.constraint(
                equalTo: safeArea.widthAnchor,
                multiplier: 0.85
            ),
            
            // MARK: activityIndicator Constraints
            activityIndicator.centerXAnchor.constraint(
                equalTo: safeArea.centerXAnchor
            ),
            activityIndicator.centerYAnchor.constraint(
                equalTo: safeArea.centerYAnchor
            )
        ])
    }
}
