//
//  AddArticleView.swift
//  HeartHub
//
//  Created by 제민우 on 2023/08/16.
//

import UIKit

final class PostArticleView: UIView {
    
    let postArticleCellPagingImageView = CommunityCellPagingImageView()
    
    var postArticleProfileView = CommunityProfileView()
    
    private var isKeyboardShown = false
        
    let postArticleTextView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont(name: "Pretendard-Regular", size: 16)
        textView.textColor = .black
        textView.autocapitalizationType = .none
        textView.autocorrectionType = .no
        textView.spellCheckingType = .no
        textView.text = "문구를 입력해주세요."
        textView.textColor = #colorLiteral(red: 0.07, green: 0.07, blue: 0.07, alpha: 0.5)
        return textView
    }()
    
    var postArticleDailyButton = PostArticleButton(
        text: "Daily",
        backgroundColor: .black,
        theme: .daily
    )
    var postArticleLookButton = PostArticleButton(
        text: "Look",
        backgroundColor: .white,
        theme: .look
    )
    var postArticleDateButton = PostArticleButton(
        text: "Date",
        backgroundColor: .white,
        theme: .date
    )
    
    private let postArticleButtonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 0
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        
        stackView.backgroundColor = .white
        
        stackView.layer.shadowColor = UIColor.black.cgColor
        stackView.layer.masksToBounds = false
        stackView.layer.shadowOffset = CGSize(width: 0, height: 4)
        stackView.layer.shadowRadius = 5
        stackView.layer.shadowOpacity = 0.3
        
        return stackView
    }()
    
    // MARK: Initializer
    override init(frame: CGRect) {
        super.init(frame: .zero)
        configureSubviews()
        configureNotification()
        configureLayout()
        configureInitialSetting()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        postArticleButtonStackView.layer.cornerRadius = postArticleButtonStackView.frame.height / CGFloat(2)
        
        postArticleTextView.textContainerInset = UIEdgeInsets(top: postArticleProfileView.frame.height, left: 25, bottom: 0, right: 25)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}

// MARK: Configure InitialSetting
extension PostArticleView {
    private func configureInitialSetting() {
        postArticleTextView.delegate = self
        postArticleDailyButton.isSelected = true
    }
}

// MARK: Configure Notification
extension PostArticleView {
    private func configureNotification() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardUpAction),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardDownAction),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    @objc private func keyboardUpAction(notification: NSNotification) {
        
        guard !isKeyboardShown else {
            return
        }
        
        guard let userInfo: NSDictionary = notification.userInfo as? NSDictionary else {
            return
        }
        guard let keyboardFrame = userInfo.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as? NSValue else {
            return
        }
        let keyboardRectangle = keyboardFrame.cgRectValue
        let keyboardHeight = keyboardRectangle.height
        
        isKeyboardShown = true

        self.frame.origin.y -= keyboardHeight
        
        UIView.animate(withDuration: 0.2) {
            self.layoutIfNeeded()
        }
    }
    
    @objc private func keyboardDownAction() {
        isKeyboardShown = false
        
        self.frame.origin.y = 0

        UIView.animate(withDuration: 0.2) {
            self.layoutIfNeeded()
        }
    }
}

// MARK: Configure Layout
extension PostArticleView {
    
    private func configureSubviews() {
        postArticleTextView.addSubview(postArticleProfileView)
        postArticleTextView.translatesAutoresizingMaskIntoConstraints = false
        
        [postArticleDailyButton, postArticleLookButton, postArticleDateButton].forEach {
            postArticleButtonStackView.addArrangedSubview($0)
        }
        
        [postArticleCellPagingImageView,
         postArticleTextView,
         postArticleProfileView,
         postArticleButtonStackView
        ].forEach {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    private func configureLayout() {
        let safeArea = safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([

            // MARK: postImageView Constraints
            postArticleCellPagingImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.462),
            postArticleCellPagingImageView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            postArticleCellPagingImageView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            postArticleCellPagingImageView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            postArticleCellPagingImageView.widthAnchor.constraint(equalTo: postArticleCellPagingImageView.heightAnchor),

            // MARK: postArticleProfileView Constraints
            postArticleProfileView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.077),
            postArticleProfileView.centerXAnchor.constraint(equalTo: centerXAnchor),
            postArticleProfileView.topAnchor.constraint(equalTo: postArticleTextView.topAnchor),
            postArticleProfileView.leadingAnchor.constraint(equalTo: postArticleTextView.leadingAnchor, constant: 25),

            // MARK: postArticleTextField Constraints
            postArticleTextView.centerXAnchor.constraint(equalTo: centerXAnchor),

            postArticleTextView.topAnchor.constraint(equalTo: postArticleCellPagingImageView.bottomAnchor),
            postArticleTextView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            postArticleTextView.leadingAnchor.constraint(equalTo: leadingAnchor),
            
            // MARK: postArticleButtonStackView Constraints
            postArticleButtonStackView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.066),
            postArticleButtonStackView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.512),
            postArticleButtonStackView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -21),
            postArticleButtonStackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -21),
        ])
    }
}

// MARK: GestureRecognizer Delegate Implement
extension PostArticleView: UIGestureRecognizerDelegate {
    func configureTapPostImageAction(_ target: Any, _ action: Selector) {
        let tapGesture = UITapGestureRecognizer(target: target, action: action)
        tapGesture.delegate = self
        postArticleCellPagingImageView.isUserInteractionEnabled = true
        postArticleCellPagingImageView.addGestureRecognizer(tapGesture)
    }
}

// MARK: TextView Delegate Implement
extension PostArticleView: UITextViewDelegate {
    // 플레이스홀더 기능 구현
    func textViewDidBeginEditing(_ textView: UITextView) {
        if postArticleTextView.text == "문구를 입력해주세요." {
            postArticleTextView.text = nil
            postArticleTextView.textColor = .black
        }
        postArticleTextView.textColor = .black
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if postArticleTextView.text == "" {
            postArticleTextView.text = "문구를 입력해주세요."
            postArticleTextView.textColor = #colorLiteral(red: 0.07, green: 0.07, blue: 0.07, alpha: 0.5)
        }
    }
    
    // 텍스트뷰를 이외의 영역을 눌렀을때 키보드 내려가도록
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        postArticleTextView.resignFirstResponder()
    }
}
