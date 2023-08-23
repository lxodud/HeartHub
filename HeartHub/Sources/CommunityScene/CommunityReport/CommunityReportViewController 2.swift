//
//  PostReportViewController.swift
//  HeartHub
//
//  Created by 제민우 on 2023/08/23.
//

import UIKit

final class CommunityReportViewController: UIViewController {
    
    private let communityReportReasonLabel: UILabel = {
        let label = UILabel()
        label.text = "신고사유"
        label.textAlignment = .center
        label.font = UIFont(name: "Pretendard-SemiBold", size: 24)
        label.adjustsFontForContentSizeCategory = true
        label.textColor = .black
        return label
    }()
    
    private var closeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "CloseButton"), for: .normal)
        return button
    }()
    
    private var communityReportButton = AlertButton(buttonColor: .white, borderColor: #colorLiteral(red: 0.9803773761, green: 0.1853338182, blue: 0.7394250631, alpha: 1), title: "신고하기", titleColor: .black)

    private let communityReportReasonTextView: UITextView = {
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
    
    private let communityReportReasonTableView = UITableView()
    
    private let reasonsArray = [
    "음란성/ 선정성",
    "개인정보 노출",
    "욕설/ 인신공격",
    "같은 내용 반복게시",
    "영리목적/ 홍보성",
    "기타"
    ]
    
    private var notShowCheckButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "RadioBtnUnChecked"), for: .normal)
        button.setImage(UIImage(named: "RadioBtnChecked"), for: .selected)
        button.contentMode = .scaleAspectFit
        return button
    }()
    
    private var notShowLabel: UILabel = {
        let label = UILabel()
        label.text = "해당 게시물 다시보지 않기"
        label.font = UIFont(name: "Pretendard-Regular", size: 16)
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        label.textColor = #colorLiteral(red: 0.07, green: 0.07, blue: 0.07, alpha: 1)
        return label
    }()
    
    private lazy var notShowStackView: UIStackView = {
       let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 9
        stackView.alignment = .center
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
    private var reasonCheckButtonStates: [Int: Bool] = [:]
    
    private var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.clipsToBounds = true
        view.layer.cornerRadius = 18
        return view
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureSubviews()
        configureLayout()
        tableViewInitialSetting()
        configureAddTarget()
        
        configureNotification()
        communityReportReasonTextView.delegate = self
        view.backgroundColor = UIColor(red: 0.067, green: 0.067, blue: 0.067, alpha: 0.2)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}

// MARK: Configure Notification
extension CommunityReportViewController {
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
extension CommunityReportViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let rowHeight = tableView.frame.height / CGFloat(reasonsArray.count)
        return rowHeight
    }
}

// MARK: TableView DataSource Implement
extension CommunityReportViewController: UITableViewDataSource {
    
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
extension CommunityReportViewController {
    private func tableViewInitialSetting() {
        communityReportReasonTableView.delegate = self
        communityReportReasonTableView.dataSource = self
        communityReportReasonTableView.register(
            ProfileReportReasonTableViewCell.self,
            forCellReuseIdentifier: ProfileReportReasonTableViewCell.reuseIdentifier)
        communityReportReasonTableView.isScrollEnabled = false
        communityReportReasonTableView.separatorStyle = .none
        
        for key in 0..<6 {
            reasonCheckButtonStates[key] = false
        }
        
        communityReportButton.isEnabled = false
    }
}

// MARK: Configure Layout
extension CommunityReportViewController {
    private func configureSubviews() {
        
        [notShowCheckButton, notShowLabel].forEach {
            notShowStackView.addArrangedSubview($0)
        }
        
        [
         communityReportReasonLabel,
         closeButton,
         communityReportReasonTableView,
         communityReportReasonTextView,
         notShowStackView,
         communityReportButton
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
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 67),
            containerView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 30),
            
            communityReportReasonLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 30),
            communityReportReasonLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 30),
            
            closeButton.centerYAnchor.constraint(equalTo: communityReportReasonLabel.centerYAnchor),
            closeButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -30),
            
            communityReportReasonTableView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            communityReportReasonTableView.topAnchor.constraint(equalTo: communityReportReasonLabel.bottomAnchor, constant: 32),
            communityReportReasonTableView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 38),
//            communityReportReasonTableView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -283),
            
            communityReportReasonTextView.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 0.182),
            communityReportReasonTextView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            communityReportReasonTextView.topAnchor.constraint(equalTo: communityReportReasonTableView.bottomAnchor, constant: 16),
            communityReportReasonTextView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 30),
            
            notShowStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            notShowStackView.topAnchor.constraint(equalTo: communityReportReasonTextView.bottomAnchor, constant: 20),
            notShowStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 38),
            

            communityReportButton.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 0.063),
            communityReportButton.topAnchor.constraint(equalTo: notShowStackView.bottomAnchor, constant: 19),
            communityReportButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            communityReportButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -30),
            communityReportButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 30),
        ])
    }
}

// MARK: Configure AddTarget
extension CommunityReportViewController {
    private func configureAddTarget() {
        
        communityReportButton.addTarget(
            self,
            action: #selector(didTapProfileCommunityReportButton),
            for: .touchUpInside
        )
        notShowCheckButton.addTarget(
            self,
            action: #selector(didTapNotShowCheckButton),
            for: .touchUpInside
        )
        closeButton.addTarget(self, action: #selector(didTapCloseButton), for: .touchUpInside)
    }
    
    @objc private func didTapProfileCommunityReportButton() {
        let profileDoneReportViewController = ProfileDoneReportViewController()
        modalPresentationStyle = .overFullScreen
        present(profileDoneReportViewController, animated: true)
    }
    
    @objc func reasonCheckButton(sender: UIButton) {
        switch sender.tag {
        case 0...4:
            reasonCheckButtonStates[sender.tag] = sender.isSelected
            let buttonSelected = (0...3).contains(where: {reasonCheckButtonStates[$0] == true})
            communityReportButton.isEnabled = buttonSelected
            communityReportReasonTextView.isEditable = false
        case 5:
            reasonCheckButtonStates[sender.tag] = sender.isSelected
            if communityReportReasonTextView.text == "" && communityReportReasonTextView.text == "이유를 작성해주십시오." {
                communityReportButton.isEnabled = false
            }
            else {
                communityReportButton.isEnabled = true
            }
        default:
            reasonCheckButtonStates[sender.tag] = false
        }
    }
    
    @objc private func didTapNotShowCheckButton() {
        notShowCheckButton.isSelected.toggle()
    }
    
    @objc private func didTapCloseButton() {
        dismiss(animated: true)
    }
}

// MARK: TextView Delegate Implement
extension CommunityReportViewController: UITextViewDelegate {
    // 플레이스홀더 기능 구현
    func textViewDidBeginEditing(_ textView: UITextView) {
        if communityReportReasonTextView.text == "이유를 작성해주십시오." {
            communityReportReasonTextView.text = ""
            communityReportReasonTextView.textColor = .black
        }
        communityReportReasonTextView.textColor = .black
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if communityReportReasonTextView.text == "" {
            communityReportReasonTextView.text = "이유를 작성해주십시오."
            communityReportReasonTextView.textColor = #colorLiteral(red: 0.07, green: 0.07, blue: 0.07, alpha: 0.5)
        }
    }
    
    // 텍스트뷰를 이외의 영역을 눌렀을때 키보드 내려가도록
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        communityReportReasonTextView.resignFirstResponder()
    }
}

// MARK: 프리뷰
import SwiftUI
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Container().edgesIgnoringSafeArea(.all)
    }
    struct Container: UIViewControllerRepresentable {
        func makeUIViewController(context: Context) -> UIViewController {
            return     UINavigationController(rootViewController: CommunityReportViewController())
        }
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        }
        typealias  UIViewControllerType = UIViewController
    }
}
