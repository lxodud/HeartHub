//
//  AlbumPostViewController.swift
//  HeartHub
//
//  Created by 이태영 on 2023/11/09.
//

import RxCocoa
import RxSwift
import UIKit

final class AlbumPostViewController: UIViewController {
    private let viewModel: AlbumPostViewModel
    private let disposeBag = DisposeBag()
    
    private let scrollView = UIScrollView()
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "AddPostImage")
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    private let titleTextField: UITextField = {
        let textField = UITextField()
        textField.font = UIFont(name: "Pretendard-SemiBold", size: 20)
        textField.textColor = .black
        textField.placeholder = "제목을 입력해주세요."
        textField.textColor = .black
        return textField
    }()
    
    private let bodyTextView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont(name: "Pretendard-SemiBold", size: 16)
        textView.textColor = .systemGray3
        textView.text = "내용을 입력해주세요."
        textView.isScrollEnabled = false
        return textView
    }()
    
    private let postButton: UIBarButtonItem = {
        let barButton = UIBarButtonItem(
            title: "완료",
            style: .plain,
            target: nil,
            action: nil
        )
        barButton.isEnabled = false
        return barButton
    }()
    
    private let cancelButton: UIBarButtonItem = {
        let barButton = UIBarButtonItem(
            title: "취소",
            style: .plain,
            target: nil,
            action: nil
        )
        
        return barButton
    }()
    
    private let activityIndicator = UIActivityIndicatorView()
    
    init(viewModel: AlbumPostViewModel) {
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
        configureNavigation()
        bind(to: viewModel)
        bindUI()
    }

    private func bind(to viewModel: AlbumPostViewModel) {
        let imagePickerTapGesture = UITapGestureRecognizer()
        imageView.addGestureRecognizer(imagePickerTapGesture)
        
        let imagePickerTap = imagePickerTapGesture.rx.event
            .map { _ in }
            .asDriver(onErrorJustReturn: ())
        
        let input = AlbumPostViewModel.Input(
            imagePickerTap: imagePickerTap,
            title: titleTextField.rx.text.orEmpty.asDriver(),
            body: bodyTextView.rx.text.orEmpty.asDriver(),
            textViewEditEnd: bodyTextView.rx.didEndEditing.asDriver(),
            textViewEditStart: bodyTextView.rx.didBeginEditing.asDriver(),
            postTap: postButton.rx.tap.asDriver(),
            cancelTap: cancelButton.rx.tap.asDriver()
        )
        
        let output = viewModel.transform(input)
        
        output.toImagePicker
            .drive()
            .disposed(by: disposeBag)
        
        output.bodyPlaceholder
            .drive(bodyTextView.rx.text)
            .disposed(by: disposeBag)
        
        output.bodyColor
            .drive(onNext: { [weak self] in
                self?.bodyTextView.textColor = $0.uiColor
            })
            .disposed(by: disposeBag)
        
        output.postImage
            .drive(onNext: { [weak self] data in
                self?.imageView.image = UIImage(data: data)
            })
            .disposed(by: disposeBag)
        
        output.postEnalble
            .drive(postButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        output.cancel
            .drive()
            .disposed(by: disposeBag)
        
        output.posting
            .drive(activityIndicator.rx.isAnimating)
            .disposed(by: disposeBag)
        
        output.postSuccess
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
        
        NotificationCenter.default.rx
            .notification(UIResponder.keyboardWillShowNotification)
            .filter { [weak self] _ in
                guard let self = self else {
                    return false
                }
                
                return self.view.frame.origin.y >= 0
            }
            .mapKeyboardHeight()
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] in
                guard let self = self else {
                    return
                }
                
                self.view.frame.origin.y -= $0
            })
            .disposed(by: disposeBag)
        
        NotificationCenter.default.rx
            .notification(UIResponder.keyboardWillHideNotification)
            .filter { [weak self] _ in
                guard let self = self else {
                    return false
                }
                
                return self.view.frame.origin.y < 0
            }
            .mapKeyboardHeight()
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] in
                guard let self = self else {
                    return
                }
                
                self.view.frame.origin.y += $0
            })
            .disposed(by: disposeBag)
    }
}

extension AlbumPostViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        if scrollView.contentSize.height > scrollView.bounds.height {
            let contentOffsetToBottom = scrollView.contentSize.height - scrollView.bounds.height
            scrollView.setContentOffset(
                CGPoint(x: 0, y: contentOffsetToBottom),
                animated: true
            )
        }
    }
}

// MARK: - Configure UI
extension AlbumPostViewController {
    private func configureSuperview() {
        view.backgroundColor = .systemBackground
        bodyTextView.delegate = self
    }
    
    private func configureSubview() {
        [imageView, titleTextField, bodyTextView, activityIndicator].forEach {
            scrollView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configureLayout() {
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            // MARK: scrollView Constraints
            scrollView.topAnchor.constraint(
                equalTo: safeArea.topAnchor
            ),
            scrollView.leadingAnchor.constraint(
                equalTo: safeArea.leadingAnchor
            ),
            scrollView.trailingAnchor.constraint(
                equalTo: safeArea.trailingAnchor
            ),
            scrollView.bottomAnchor.constraint(
                equalTo: safeArea.bottomAnchor
            ),
            
            // MARK: imageView Constraints
            imageView.topAnchor.constraint(
                equalTo: scrollView.contentLayoutGuide.topAnchor
            ),
            imageView.leadingAnchor.constraint(
                equalTo: scrollView.frameLayoutGuide.leadingAnchor
            ),
            imageView.trailingAnchor.constraint(
                equalTo: scrollView.frameLayoutGuide.trailingAnchor
            ),
            imageView.heightAnchor.constraint(
                equalTo: safeArea.heightAnchor,
                multiplier: 0.5
            ),
            
            // MARK: titleTextField Constraints
            titleTextField.topAnchor.constraint(
                equalTo: imageView.bottomAnchor,
                constant: 5
            ),
            titleTextField.leadingAnchor.constraint(
                equalTo: scrollView.frameLayoutGuide.leadingAnchor,
                constant: 5
            ),
            titleTextField.trailingAnchor.constraint(
                equalTo: scrollView.frameLayoutGuide.trailingAnchor,
                constant: -5
            ),
            
            // MARK: bodyTextView Constraints
            bodyTextView.topAnchor.constraint(
                equalTo: titleTextField.bottomAnchor
            ),
            bodyTextView.leadingAnchor.constraint(
                equalTo: scrollView.frameLayoutGuide.leadingAnchor
            ),
            bodyTextView.trailingAnchor.constraint(
                equalTo: scrollView.frameLayoutGuide.trailingAnchor
            ),
            bodyTextView.bottomAnchor.constraint(
                equalTo: scrollView.contentLayoutGuide.bottomAnchor
            ),
            
            // MARK: activityIndicator Constraints
            activityIndicator.centerXAnchor.constraint(
                equalTo: safeArea.centerXAnchor
            ),
            activityIndicator.centerYAnchor.constraint(
                equalTo: safeArea.centerYAnchor
            ),
        ])
    }
    
    private func configureNavigation() {
        navigationItem.title = "앨범작성"
        navigationItem.rightBarButtonItem = postButton
        navigationItem.rightBarButtonItem?.tintColor = .black
        
        navigationItem.leftBarButtonItem = cancelButton
        navigationItem.leftBarButtonItem?.tintColor = .black
    }
}

enum AlbumPostColor {
    case placeholder
    case text
    
    var uiColor: UIColor {
        switch self {
        case .placeholder:
            return .systemGray3
        case .text:
            return .black
        }
    }
}
