//
//  StartDateInputViewController.swift
//  HeartHub
//
//  Created by 이태영 on 2023/09/23.
//

import RxCocoa
import RxSwift
import UIKit

final class StartDateInputViewController: UIViewController {
    private let viewModel: StartDateInputViewModel
    private let disposeBag = DisposeBag()
    
    private let titleLabel = SignUpTitleLabelStackView(
        title: "우리의 시작",
        description: "당신이 애인과 처음 사귀기 시작한 날은 언제인가요?"
    )
    
    private let dateTextField: UITextField = SignUpDateTextField(placeholder: "우리의 시작")
    private let selectDoneButton = UIBarButtonItem(systemItem: .done)
    
    private let startDatePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.locale = Locale(identifier: "ko-KR")
        datePicker.maximumDate = Date()
        return datePicker
    }()
    
    private let nextButton: UIButton = SignUpBottomButton(title: "다음")
    
    init(viewModel: StartDateInputViewModel = StartDateInputViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        configureSubview()
        configureLayout()
        configureNavigationBar()
        bind(to: viewModel)
        bindUI()
    }
    
    private func bind(to viewModel: StartDateInputViewModel) {
        let date = selectDoneButton.rx.tap.withLatestFrom(startDatePicker.rx.date)
        
        let input = StartDateInputViewModel.Input(
            date: date
        )
        
        let output = viewModel.transform(input)
        
        output.formattedDate
            .do { _ in self.view.endEditing(true) }
            .drive(dateTextField.rx.text)
            .disposed(by: disposeBag)
        
        output.isNextEnable
            .drive(nextButton.rx.isEnabled)
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

// MARK: Configure UI
extension StartDateInputViewController {
    private func configureSubview() {
        [titleLabel, dateTextField, nextButton].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        let toolBar = UIToolbar()
        let flexibleSpace = UIBarButtonItem(systemItem: .flexibleSpace)
        toolBar.items = [flexibleSpace, selectDoneButton]
        toolBar.sizeToFit()
        
        dateTextField.inputAccessoryView = toolBar
        dateTextField.inputView = startDatePicker
    }
    
    private func configureLayout() {
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            // MARK: titleLabel Constraints
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
            
            // MARK: dateTextField Constraints
            dateTextField.topAnchor.constraint(
                equalTo: titleLabel.bottomAnchor,
                constant: 30
            ),
            dateTextField.centerXAnchor.constraint(
                equalTo: safeArea.centerXAnchor
            ),
            dateTextField.widthAnchor.constraint(
                equalTo: safeArea.widthAnchor,
                multiplier: 0.8
            ),
            dateTextField.heightAnchor.constraint(
                equalToConstant: 35
            ),
            
            // MARK: nextButton Constraints
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
        let titleImage = UIImage(named: "HeartIcon0:3")
        let titleImageView = UIImageView()
        titleImageView.contentMode = .scaleAspectFit
        titleImageView.image = titleImage
        navigationItem.titleView = titleImageView
    }
}
