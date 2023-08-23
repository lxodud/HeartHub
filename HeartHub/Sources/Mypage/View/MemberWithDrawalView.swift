//
//  MemberWithdrawalView.swift
//  HeartHub
//
//  Created by 전제윤 on 2023/08/09.
//

import UIKit

final class MemberWithdrawalView: UIView {
    
    let unCheckedbtnImg = UIImage(named: "AgreeRadioBtnUnChecked")
    
    private var memberWithdrawalLabel: UILabel = {
        let label = UILabel()
        label.text = "회원 탈퇴"
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.textColor = .black
        return label
    }()
    
    private var memberWithdrawalDetailLabel: UILabel = {
        let label = UILabel()
        label.text = "잠깐! 탈퇴 전, 아래의 사항을 꼭 확인해주세요."
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 2
        label.textColor = .lightGray
        label.textAlignment = .center
        return label
    }()
    
    private lazy var allAgreeView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        view.layer.borderWidth = 1.0
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.layer.shadowColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.25).cgColor
        view.layer.shadowOpacity = 0.4
        view.layer.shadowOffset = CGSize(width: 2, height: 4)
        view.layer.shadowRadius = 1
        
        view.addSubview(allAgreeLabel)
        return view
    }()
    
    private var allAgreeLabel: UILabel = {
        let label = UILabel()
        label.text = "탈퇴 시 모든 데이터가 사라지며, 복구 불가합니다."
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .center
        let attributedText = NSMutableAttributedString(string: label.text ?? "")
        let range = (label.text as NSString?)?.range(of: "복구 불가")
        if let range = range {
            attributedText.addAttribute(.foregroundColor, value: UIColor(named: "mediumpink"), range: range)
        }
        label.attributedText = attributedText
        return label
    }()
    
    lazy var allAgreebtn: UIButton = {
        var btn = UIButton(type: .custom)
        let unCheckedImg = UIImage(named:"UnCheckBox")
        btn.setImage(unCheckedImg, for: .normal)
        return btn
    }()
    
    private let allAgreeDetailLabel: UILabel = {
        let label = UILabel()
        label.text = "안내사항을 모두 확인하였으며 이에 동의합니다."
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .lightGray
        label.textAlignment = .center
        return label
    }()
    
    private lazy var allAgreeStackView: UIStackView = {
        let stView = UIStackView(arrangedSubviews: [allAgreebtn, allAgreeDetailLabel])
        stView.spacing = 3
        stView.axis = .horizontal
        stView.distribution = .fillProportionally
        stView.alignment = .center
        
        
        return stView
    }()
    
    
    
    private var withdrawalReasonLabel: UILabel = {
        let label = UILabel()
        let attributedText = NSMutableAttributedString(string: "탈퇴 사유 (복수 선택 가능)")
        let boldRange = (attributedText.string as NSString).range(of: "탈퇴 사유")
        let fontSize = UIFont.systemFont(ofSize: 17, weight: .bold)
        attributedText.addAttribute(.font, value: fontSize, range: boldRange)
        label.attributedText = attributedText
        let smallRange = (attributedText.string as NSString).range(of: "(복수 선택 가능)")
        let smallFontSize = UIFont.systemFont(ofSize: 14)
        attributedText.addAttribute(.font, value: smallFontSize, range: smallRange)
        label.attributedText = attributedText
        return label
    }()
    
    private var reasonLabel1: UILabel = {
        let label = UILabel()
        label.text = "애인과 헤어지게 됐습니다."
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    private var reasonLabel2: UILabel = {
        let label = UILabel()
        label.text = "본 앱에 더이상 흥미가 없습니다."
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    private var reasonLabel3: UILabel = {
        let label = UILabel()
        label.text = "기술적인 문제 및 버그가 발생하였습니다."
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    private var reasonLabel4: UILabel = {
        let label = UILabel()
        label.text = "기타(서술해주십시오.)"
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    private lazy var reasonStackView: UIStackView = {
        let stView = UIStackView(arrangedSubviews: [reasonLabel1, reasonLabel2, reasonLabel3, reasonLabel4])
        stView.spacing = 25
        stView.axis = .vertical
        stView.distribution = .fillEqually
        stView.alignment = .fill
        return stView
    }()
    
    lazy var reasonbtn1: UIButton = {
        var btn = UIButton(type: .custom)
        btn.backgroundColor = .clear
        btn.setImage(unCheckedbtnImg, for: .normal)
        btn.imageView?.contentMode = .scaleAspectFit
        btn.contentHorizontalAlignment = .center
        return btn
    }()
    
    lazy var reasonbtn2: UIButton = {
        var btn = UIButton(type: .custom)
        let unCheckedImg = UIImage(named:"AgreeRadioBtnUnChecked")
        btn.setImage(unCheckedImg, for: .normal)
        return btn
    }()
    
    lazy var reasonbtn3: UIButton = {
        var btn = UIButton(type: .custom)
        let unCheckedImg = UIImage(named:"AgreeRadioBtnUnChecked")
        btn.setImage(unCheckedImg, for: .normal)
        return btn
    }()
    
    lazy var reasonbtn4: UIButton = {
        var btn = UIButton(type: .custom)
        let unCheckedImg = UIImage(named:"AgreeRadioBtnUnChecked")
        btn.setImage(unCheckedImg, for: .normal)
        return btn
    }()
    
    private lazy var reasonbtnStackView: UIStackView = {
        let stView = UIStackView(arrangedSubviews: [reasonbtn1, reasonbtn2, reasonbtn3, reasonbtn4])
        stView.spacing = 3
        stView.axis = .vertical
        stView.distribution = .fillEqually
        stView.alignment = .fill
        return stView
    }()
    
    private lazy var reasonTextField: UITextField = {
        let tf = UITextField()
        tf.backgroundColor = .clear
        tf.textColor = #colorLiteral(red: 0.07, green: 0.07, blue: 0.07, alpha: 0.5)
        tf.autocapitalizationType = .none
        
        let placeholderAttrString = NSAttributedString(string: "이유를 작성해주십시오.",
                                                       attributes: [NSAttributedString.Key.foregroundColor :
                                                                        UIColor(red: 0.067, green: 0.067, blue: 0.067,
                                                                                alpha: 0.5),
                                                                    NSAttributedString.Key.font:
                                                                        UIFont(name: "Pretendard-Regular", size: 14)!])
        tf.attributedPlaceholder = placeholderAttrString
        tf.layer.cornerRadius = 15
        tf.layer.borderWidth = 1.0
        tf.layer.borderColor = UIColor.darkGray.cgColor
        tf.textAlignment = .left
        tf.tintColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: tf.frame.height))
        tf.leftView = paddingView
        tf.leftViewMode = .always
        tf.tintColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
        
        return tf
    }()
    
   let memberWithdrawalBtn: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = .red
        button.layer.cornerRadius = 16
        button.layer.shadowColor = #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)
        button.layer.shadowOpacity = 0.4
        button.layer.shadowOffset = CGSize(width: 2, height: 4)
        button.layer.shadowRadius = 1
        button.setTitle("계정 삭제", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.isEnabled = false
        return button
    }()
    
    //MARK: - 뷰 초기화
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
        setConstraints()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - 뷰 추가 및 제약
    
    private func addViews() {
        [memberWithdrawalLabel,memberWithdrawalDetailLabel,allAgreeView, allAgreeStackView, allAgreeLabel,withdrawalReasonLabel,reasonStackView,reasonbtnStackView, reasonTextField, memberWithdrawalBtn].forEach{ addSubview($0)}
    }
    
    private func setConstraints() {
        memberWithdrawalLabelConstraints()
        memberWithdrawalDetailLabelConstraints()
        allAgreeViewConstraints()
        allAgreeLabelConstraints()
        allAgreeStackViewConstraints()
        withdrawalReasonLabelConstraints()
        reasonStackViewConstraints()
        reasonbtnStackViewConstraints()
        reasonTextFieldConstraints()
        memberWithdrawalBtnConstraints()
    }
    
    private func memberWithdrawalLabelConstraints() {
        memberWithdrawalLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            memberWithdrawalLabel.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            memberWithdrawalLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 30)
        ])
    }
    
    private func memberWithdrawalDetailLabelConstraints() {
        memberWithdrawalDetailLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            memberWithdrawalDetailLabel.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            memberWithdrawalDetailLabel.topAnchor.constraint(equalTo: memberWithdrawalLabel.bottomAnchor, constant: 20),
            memberWithdrawalDetailLabel.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 0.5),
        ])
    }
    
    private func allAgreeViewConstraints() {
        allAgreeView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            allAgreeView.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            allAgreeView.topAnchor.constraint(equalTo: memberWithdrawalDetailLabel.bottomAnchor, constant: 30),
            allAgreeView.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.18),
            allAgreeView.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 0.8)
        ])
    }
    
    private func allAgreeLabelConstraints() {
        allAgreeLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            allAgreeLabel.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            allAgreeLabel.topAnchor.constraint(equalTo: allAgreeView.topAnchor, constant: 40)
        ])
    }
    
    private func allAgreeStackViewConstraints(){
        allAgreeStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            allAgreeStackView.centerXAnchor.constraint(equalTo: allAgreeView.centerXAnchor),
            allAgreeStackView.topAnchor.constraint(equalTo: allAgreeLabel.bottomAnchor, constant: 20),
            allAgreeStackView.widthAnchor.constraint(equalTo: allAgreeView.widthAnchor, multiplier: 0.9)
        ])
    }
    
    private func withdrawalReasonLabelConstraints() {
        withdrawalReasonLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            withdrawalReasonLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 40),
            withdrawalReasonLabel.topAnchor.constraint(equalTo: allAgreeView.bottomAnchor, constant: 20)
        ])
    }
    
    private func reasonStackViewConstraints() {
        reasonStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            reasonStackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 60),
            reasonStackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -90),
            reasonStackView.topAnchor.constraint(equalTo: withdrawalReasonLabel.bottomAnchor, constant: 20),
        ])
    }
    
    private func reasonbtnStackViewConstraints() {
        reasonbtnStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            reasonbtnStackView.leadingAnchor.constraint(equalTo: reasonStackView.trailingAnchor, constant: 1),
            reasonbtnStackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -1),
            reasonbtnStackView.topAnchor.constraint(equalTo: withdrawalReasonLabel.bottomAnchor, constant: 10)
        ])
    }
    
    
    
    private func reasonTextFieldConstraints() {
        reasonTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            reasonTextField.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            reasonTextField.topAnchor.constraint(equalTo: reasonStackView.bottomAnchor, constant: 20),
            reasonTextField.heightAnchor.constraint(equalTo: allAgreeView.heightAnchor, multiplier: 0.5),
            reasonTextField.widthAnchor.constraint(equalTo: allAgreeView.widthAnchor, multiplier: 1)
        ])
    }
    
    
    
    
    private func memberWithdrawalBtnConstraints() {
        memberWithdrawalBtn.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            memberWithdrawalBtn.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            memberWithdrawalBtn.topAnchor.constraint(equalTo: reasonTextField.bottomAnchor, constant: 20),
            memberWithdrawalBtn.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.09),
            memberWithdrawalBtn.widthAnchor.constraint(equalTo: allAgreeView.widthAnchor, multiplier: 1)
        ])
    }
}

