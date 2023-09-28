//
//  AccountProfileInputViewController.swift
//  HeartHub
//
//  Created by 이태영 on 2023/09/24.
//

import RxCocoa
import RxSwift
import UIKit

final class AccountProfileInputViewController: UIViewController {
    private let viewModel: AccountProfileInputViewModel
    private let disposeBag = DisposeBag()
    
    private let titleLabel = SignUpTitleLabelStackView(
        title: "사랑을 시작해볼까요?",
        description: "계정을 생성하여 HeartHub를 즐겨보아요."
    )
    
    private let idTextField = HeartHubUserInfoInputTextField(
        placeholder: "아이디를 입력하세요",
        keyboardType: .default,
        isSecureTextEntry: false
    )
    private let idCheckButton: UIButton = {
        let button = UIButton()
        button.setTitle("중복 확인", for: .normal)
        button.setTitleColor(UIColor(red: 0.46, green: 0.46, blue: 0.46, alpha: 1), for: .normal)
        button.titleLabel?.font = UIFont(name: "Pretendard-Regular", size: 14)
        button.backgroundColor = .systemGray3
        button.clipsToBounds = true
        button.layer.cornerRadius = 18
        return button
    }()
    private let idDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "영문/숫자 구성"
        label.font = UIFont(name: "Pretendard-Regular", size: 12)
        label.textColor = UIColor(red: 0.46, green: 0.46, blue: 0.46, alpha: 1)
        return label
    }()
    
    private let passwordTextField = HeartHubUserInfoInputTextField(
        placeholder: "비밀번호를 입력하세요",
        keyboardType: .default,
        isSecureTextEntry: true
    )
    private let passwordSecureButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "hidePassword"), for: .normal)
        button.setImage(UIImage(named: "showPassword"), for: .selected)
        button.titleLabel?.font = UIFont(name: "Pretendard-Regular", size: 14)
        return button
    }()
    private let passwordDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "영문/숫자/특수문자 구성"
        label.font = UIFont(name: "Pretendard-Regular", size: 12)
        label.textColor = UIColor(red: 0.46, green: 0.46, blue: 0.46, alpha: 1)
        return label
    }()
    
    private let maleCheckBox: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "RadioButtonUnChecked"), for: .normal)
        button.setImage(UIImage(named: "RadioButtonChecked"), for: .selected)
        return button
    }()
    private let maleLabel: UILabel = {
        let label = UILabel()
        label.text = "남"
        label.font = UIFont(name: "Pretendard-Regular", size: 14)
        label.textAlignment = .center
        return label
    }()
    private let maleStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.spacing = 3
        
        stackView.layer.cornerRadius = 17
        stackView.layer.borderColor = UIColor.systemGray4.cgColor
        stackView.layer.borderWidth = 1
        
        stackView.layoutMargins = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        stackView.isLayoutMarginsRelativeArrangement = true
        
        return stackView
    }()
    
    private let femaleCheckBox: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "RadioButtonUnChecked"), for: .normal)
        button.setImage(UIImage(named: "RadioButtonChecked"), for: .selected)
        return button
    }()
    private let femaleLabel: UILabel = {
        let label = UILabel()
        label.text = "여"
        label.font = UIFont(name: "Pretendard-Regular", size: 14)
        label.textAlignment = .center
        return label
    }()
    private let femaleStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.spacing = 3
        
        stackView.layer.cornerRadius = 17
        stackView.layer.borderColor = UIColor.systemGray4.cgColor
        stackView.layer.borderWidth = 1
        
        stackView.layoutMargins = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        stackView.isLayoutMarginsRelativeArrangement = true
        
        return stackView
    }()
    
    private let birthTextField: UITextField = SignUpDateTextField(placeholder: "생년월일")
    private let selectDoneButton = UIBarButtonItem(systemItem: .done)
    private let birthDatePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.locale = Locale(identifier: "ko-KR")
        datePicker.maximumDate = Date()
        return datePicker
    }()
    
    private let nextButton: UIButton = SignUpBottomButton(title: "다음")
    
    init(viewModel: AccountProfileInputViewModel) {
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
        configureNavigationBar()
        bind(to: viewModel)
        bindUI()
    }
    
    private func bind(to viewModel: AccountProfileInputViewModel) {
        let date = selectDoneButton.rx.tap.withLatestFrom(birthDatePicker.rx.date)
        
        let input = AccountProfileInputViewModel.Input(
            id: idTextField.rx.text.orEmpty.asDriver(),
            tapCheckIdDuplication: idCheckButton.rx.tap.asDriver(),
            password: passwordTextField.rx.text.orEmpty.asDriver(),
            tapPasswordSecure: passwordSecureButton.rx.tap.asDriver(),
            tapMale: maleCheckBox.rx.tap.asDriver(),
            tapFemale: femaleCheckBox.rx.tap.asDriver(),
            birth: date,
            tapNext: nextButton.rx.tap.asDriver()
        )
        
        let output = viewModel.transform(input)
        
        output.verifiedId
            .drive(idTextField.rx.text)
            .disposed(by: disposeBag)
        
        output.idDescription
            .drive(idDescriptionLabel.rx.text)
            .disposed(by: disposeBag)
        
        output.idDescriptionColor
            .drive(onNext: {
                self.idDescriptionLabel.textColor = $0.uiColor
            })
            .disposed(by: disposeBag)
        
        output.verifiedPassword
            .drive(passwordTextField.rx.text)
            .disposed(by: disposeBag)
        
        output.isPasswordSecure
            .drive(
                passwordTextField.rx.isSecureTextEntry,
                passwordSecureButton.rx.isSelected
            )
            .disposed(by: disposeBag)
        
        output.isPasswordSecure
            .map { !$0 }
            .drive(passwordSecureButton.rx.isSelected)
            .disposed(by: disposeBag)
        
        output.isMale
            .drive(maleCheckBox.rx.isSelected)
            .disposed(by: disposeBag)
        
        output.isFemale
            .drive(femaleCheckBox.rx.isSelected)
            .disposed(by: disposeBag)
        
        output.formattedBirth
            .do { [weak self] _ in self?.view.endEditing(true) }
            .drive(birthTextField.rx.text)
            .disposed(by: disposeBag)
        
        output.isNextEnable
            .drive(nextButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        output.toNext
            .drive()
            .disposed(by: disposeBag)
    }
    
    private func bindUI() {
        let tapBackground = UITapGestureRecognizer()
        view.addGestureRecognizer(tapBackground)
        
        tapBackground.rx.event
            .subscribe(onNext: { [weak self] _ in
                self?.view.endEditing(true)
            })
            .disposed(by: disposeBag)
    }
}

// MARK: - Configure UI
extension AccountProfileInputViewController {
    private func configureSuperview() {
        view.backgroundColor = .systemBackground
    }
    
    private func configureSubview() {
        [titleLabel,
         idTextField,
         idCheckButton,
         idDescriptionLabel,
         passwordTextField,
         passwordSecureButton,
         passwordDescriptionLabel,
         maleStackView,
         femaleStackView,
         birthTextField,
         nextButton].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        [maleCheckBox, maleLabel].forEach {
            maleStackView.addArrangedSubview($0)
        }
        
        [femaleCheckBox, femaleLabel].forEach {
            femaleStackView.addArrangedSubview($0)
        }
        
        let toolBar = UIToolbar()
        let flexibleSpace = UIBarButtonItem(systemItem: .flexibleSpace)
        toolBar.items = [flexibleSpace, selectDoneButton]
        toolBar.sizeToFit()
        
        birthTextField.inputAccessoryView = toolBar
        birthTextField.inputView = birthDatePicker
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
            
            // MARK: - idTextField Constratins
            idTextField.topAnchor.constraint(
                equalTo: titleLabel.bottomAnchor,
                constant: 30
            ),
            idTextField.centerXAnchor.constraint(
                equalTo: safeArea.centerXAnchor
            ),
            idTextField.widthAnchor.constraint(
                equalTo: safeArea.widthAnchor,
                multiplier: 0.85
            ),
            idTextField.heightAnchor.constraint(
                equalToConstant: 35
            ),
            
            // MARK: - idCheckButton Constraints
            idCheckButton.topAnchor.constraint(
                equalTo: idTextField.topAnchor
            ),
            idCheckButton.trailingAnchor.constraint(
                equalTo: idTextField.trailingAnchor
            ),
            idCheckButton.bottomAnchor.constraint(
                equalTo: idTextField.bottomAnchor
            ),
            idCheckButton.widthAnchor.constraint(
                equalTo: idTextField.widthAnchor,
                multiplier: 0.2
            ),
            
            // MARK: - idDescriptionLabel Constraints
            idDescriptionLabel.topAnchor.constraint(
                equalTo: idTextField.bottomAnchor,
                constant: 5
            ),
            idDescriptionLabel.leadingAnchor.constraint(
                equalTo: idTextField.leadingAnchor,
                constant: 15
            ),
            
            // MARK: - passwordTextField Constraints
            passwordTextField.topAnchor.constraint(
                equalTo: idTextField.bottomAnchor,
                constant: 30
            ),
            passwordTextField.centerXAnchor.constraint(
                equalTo: idTextField.centerXAnchor
            ),
            passwordTextField.widthAnchor.constraint(
                equalTo: idTextField.widthAnchor
            ),
            passwordTextField.heightAnchor.constraint(
                equalTo: idTextField.heightAnchor
            ),
            
            // MARK: passwordSecureButton Constraints
            passwordSecureButton.topAnchor.constraint(
                equalTo: passwordTextField.topAnchor
            ),
            passwordSecureButton.trailingAnchor.constraint(
                equalTo: passwordTextField.trailingAnchor,
                constant: -15
            ),
            passwordSecureButton.bottomAnchor.constraint(
                equalTo: passwordTextField.bottomAnchor
            ),
            
            // MARK: - passwordDescriptionLabel Constraints
            passwordDescriptionLabel.topAnchor.constraint(
                equalTo: passwordTextField.bottomAnchor,
                constant: 5
            ),
            passwordDescriptionLabel.leadingAnchor.constraint(
                equalTo: passwordTextField.leadingAnchor,
                constant: 15
            ),
            
            // MARK: - maleStackView Constraints
            maleStackView.topAnchor.constraint(
                equalTo: passwordTextField.bottomAnchor,
                constant: 30
            ),
            maleStackView.leadingAnchor.constraint(
                equalTo: passwordTextField.leadingAnchor
            ),
            
            // MARK: - femaleStackView Constraints
            femaleStackView.centerYAnchor.constraint(
                equalTo: maleStackView.centerYAnchor
            ),
            femaleStackView.leadingAnchor.constraint(
                equalTo: maleStackView.trailingAnchor,
                constant: 20
            ),
            
            // MARK: - birthTextField Constraints
            birthTextField.topAnchor.constraint(
                equalTo: femaleStackView.bottomAnchor,
                constant: 30
            ),
            birthTextField.centerXAnchor.constraint(
                equalTo: safeArea.centerXAnchor
            ),
            birthTextField.widthAnchor.constraint(
                equalTo: safeArea.widthAnchor,
                multiplier: 0.85
            ),
            birthTextField.heightAnchor.constraint(
                equalToConstant: 35
            ),
            
            // MARK: - nextButton Constraints
            nextButton.bottomAnchor.constraint(
                equalTo: safeArea.bottomAnchor,
                constant: -30
            ),
            nextButton.centerXAnchor.constraint(
                equalTo: safeArea.centerXAnchor
            ),
            nextButton.widthAnchor.constraint(
                equalTo: safeArea.widthAnchor,
                multiplier: 0.85
            )
        ])
    }
    
    private func configureNavigationBar() {
        let titleImage = UIImage(named: "HeartIcon1:3")
        let titleImageView = UIImageView()
        titleImageView.contentMode = .scaleAspectFit
        titleImageView.image = titleImage
        navigationItem.titleView = titleImageView
    }
}
