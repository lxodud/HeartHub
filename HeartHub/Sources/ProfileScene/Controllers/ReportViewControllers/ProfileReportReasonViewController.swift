//
//  ProfileReportResonViewController.swift
//  HeartHub
//
//  Created by 제민우 on 2023/08/20.
//

import UIKit

final class ProfileReportReasonViewController: UIViewController {
    
    private var userNickName: String = "우리자기 사랑행"
    
    private lazy var userNickNameLabel: UILabel = {
        let label = UILabel()
        label.text = userNickName + "\n 님을 신고합니다."
        label.numberOfLines = 2
        label.textAlignment = .center
        label.font = UIFont(name: "Pretendard-SemiBold", size: 24)
        label.adjustsFontForContentSizeCategory = true
        label.textColor = .black
        return label
    }()
    
    private let reportReasonLabel: UILabel = {
        let label = UILabel()
        label.text = "신고사유"
        label.textAlignment = .center
        label.font = UIFont(name: "Pretendard-SemiBold", size: 16)
        label.adjustsFontForContentSizeCategory = true
        label.textColor = .black
        return label
    }()
    
    private var profileReasonCancelButton = AlertButton(buttonColor: .white, borderColor: #colorLiteral(red: 0.9803773761, green: 0.1853338182, blue: 0.7394250631, alpha: 1), title: "취소", titleColor: .black)
    private var profileReasonBlockButton = AlertButton(buttonColor:  #colorLiteral(red: 1, green: 0, blue: 0.008081941865, alpha: 1), borderColor: #colorLiteral(red: 1, green: 0, blue: 0.008081941865, alpha: 1), title: "신고", titleColor: .white)
    
    private lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [profileReasonCancelButton, profileReasonBlockButton])
        stackView.axis = .horizontal
        stackView.spacing = 42
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.clipsToBounds = true
        view.layer.cornerRadius = 18
        return view
    }()

    private let reportReasonTextView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont(name: "Pretendard-Regular", size: 16)
        textView.textColor = .black
        textView.autocapitalizationType = .none
        textView.autocorrectionType = .no
        textView.spellCheckingType = .no
        textView.text = "이유를 작성해주십시오."
        textView.textColor = #colorLiteral(red: 0.07, green: 0.07, blue: 0.07, alpha: 0.5)
        
        textView.layer.borderWidth = 1
        textView.layer.borderColor = #colorLiteral(red: 0.07, green: 0.07, blue: 0.07, alpha: 0.5)
        textView.layer.cornerRadius = 12
        
        return textView
    }()
    
    private let reportReasonView = ProfileReportReasonView()
    
    private let profileReportReasonTableView = UITableView()
    
    private let reasonsArray = [
    "욕설, 혐오 발언",
    "광고성 스팸",
    "부적절한 콘텐츠",
    "갈등 조장 및 허위사실 유포",
    "기타"
    ]
    
    private var reasonCheckButtonStates: [Int: Bool] = [:]
        
    override func loadView() {
        view = reportReasonView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureSubviews()
        configureLayout()
        tableViewInitialSetting()
        configureAddTarget()
        
        configureNotification()
        reportReasonTextView.delegate = self
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}

// MARK: Configure Notification
extension ProfileReportReasonViewController {
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
        
        guard let userInfo: NSDictionary = notification.userInfo as? NSDictionary else {
            return
        }
        guard let keyboardFrame = userInfo.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as? NSValue else {
            return
        }
        let keyboardRectangle = keyboardFrame.cgRectValue
        let keyboardHeight = keyboardRectangle.height
        

        view.frame.origin.y -= keyboardHeight
        
        UIView.animate(withDuration: 0.2) {
            self.view.layoutIfNeeded()
        }
    }
    
    @objc private func keyboardDownAction() {
        
        view.frame.origin.y = 0

        UIView.animate(withDuration: 0.2) {
            self.view.layoutIfNeeded()
        }
    }
}


// MARK: TableView Delegate Implement
extension ProfileReportReasonViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let rowHeight = tableView.frame.height / CGFloat(reasonsArray.count)
        return rowHeight
    }
}

// MARK: TableView DataSource Implement
extension ProfileReportReasonViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reasonsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: ProfileReportReasonTableViewCell.reuseIdentifier,
            for: indexPath) as? ProfileReportReasonTableViewCell else {
                return UITableViewCell()
            }
        cell.selectionStyle = .none
        
        cell.reportReasonLabel.text = reasonsArray[indexPath.row]
        
        // termAgreeButton 이벤트 처리
        cell.reasonCheckButton.tag = indexPath.row
        cell.reasonCheckButton.addTarget(
            self,
            action: #selector(reasonCheckButton(sender:)),
            for: .touchUpInside
        )

        return cell
    }
}

// MARK: TableView InitialSetting
extension ProfileReportReasonViewController {
    private func tableViewInitialSetting() {
        profileReportReasonTableView.delegate = self
        profileReportReasonTableView.dataSource = self
        profileReportReasonTableView.register(
            ProfileReportReasonTableViewCell.self,
            forCellReuseIdentifier: ProfileReportReasonTableViewCell.reuseIdentifier)
        profileReportReasonTableView.isScrollEnabled = false
        profileReportReasonTableView.separatorStyle = .none
        
        for key in 0..<5 {
            reasonCheckButtonStates[key] = false
        }
        
        profileReasonBlockButton.isEnabled = false
    }
}

// MARK: Configure Layout
extension ProfileReportReasonViewController {
    private func configureSubviews() {
        [
         userNickNameLabel,
         reportReasonLabel,
         profileReportReasonTableView,
         reportReasonTextView,
         buttonStackView
        ].forEach {
            containerView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        view.addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configureLayout() {
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 99),
            containerView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -93),
            containerView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 30),

            userNickNameLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            userNickNameLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 60),
            userNickNameLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            
            reportReasonLabel.centerXAnchor.constraint(equalTo: userNickNameLabel.centerXAnchor),
            reportReasonLabel.topAnchor.constraint(equalTo: userNickNameLabel.bottomAnchor, constant: 28),
            reportReasonLabel.leadingAnchor.constraint(equalTo: userNickNameLabel.leadingAnchor, constant: 137),
            
            profileReportReasonTableView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profileReportReasonTableView.topAnchor.constraint(equalTo: reportReasonLabel.topAnchor, constant: 24),
            profileReportReasonTableView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 30),
            profileReportReasonTableView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -170),
            
            reportReasonTextView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            reportReasonTextView.topAnchor.constraint(equalTo: profileReportReasonTableView.bottomAnchor, constant: 4),
            reportReasonTextView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 30),

            buttonStackView.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 0.063),
            buttonStackView.topAnchor.constraint(equalTo: reportReasonTextView.bottomAnchor, constant: 24),
            buttonStackView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            buttonStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -48),
            buttonStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 55),
        ])
    }
}

// MARK: Configure AddTarget
extension ProfileReportReasonViewController {
    private func configureAddTarget() {
        profileReasonCancelButton.addTarget(
            self,
            action: #selector(didTapProfileReasonCancelButton),
            for: .touchUpInside
        )
        
        profileReasonBlockButton.addTarget(
            self,
            action: #selector(didTapProfileReasonBlockButton),
            for: .touchUpInside
        )
    }
    
    @objc private func didTapProfileReasonCancelButton() {
        dismiss(animated: true)
    }
    
    @objc private func didTapProfileReasonBlockButton() {
        let profileDoneReportViewController = ProfileDoneReportViewController()
        modalPresentationStyle = .overFullScreen
        present(profileDoneReportViewController, animated: true)
    }
    
    @objc func reasonCheckButton(sender: UIButton) {
        switch sender.tag {
        case 0...3:
            reasonCheckButtonStates[sender.tag] = sender.isSelected
            let buttonSelected = (0...3).contains(where: {reasonCheckButtonStates[$0] == true})
            profileReasonBlockButton.isEnabled = buttonSelected
            reportReasonTextView.isEditable = false
        case 4:
            reasonCheckButtonStates[sender.tag] = sender.isSelected
            if reportReasonTextView.text == "" && reportReasonTextView.text == "이유를 작성해주십시오." {
                profileReasonBlockButton.isEnabled = false
            }
            else {
                profileReasonBlockButton.isEnabled = true
            }
        default:
            reasonCheckButtonStates[sender.tag] = false
        }
    }
}

// MARK: TextView Delegate Implement
extension ProfileReportReasonViewController: UITextViewDelegate {
    // 플레이스홀더 기능 구현
    func textViewDidBeginEditing(_ textView: UITextView) {
        if reportReasonTextView.text == "이유를 작성해주십시오." {
            reportReasonTextView.text = ""
            reportReasonTextView.textColor = .black
        }
        reportReasonTextView.textColor = .black
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if reportReasonTextView.text == "" {
            reportReasonTextView.text = "이유를 작성해주십시오."
            reportReasonTextView.textColor = #colorLiteral(red: 0.07, green: 0.07, blue: 0.07, alpha: 0.5)
        }
    }
    
    // 텍스트뷰를 이외의 영역을 눌렀을때 키보드 내려가도록
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        reportReasonTextView.resignFirstResponder()
    }
}
