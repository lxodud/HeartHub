//
//  AlertSetting.swift
//  HeartHub
//
//  Created by 전제윤 on 2023/08/07.
//


import UIKit

final class AlertSettingView: UIView {
    
    private var alertSettingLabel: UILabel = {
        let lb = UILabel()
        lb.text = "알림 설정"
        lb.font = UIFont.boldSystemFont(ofSize: 25)
        lb.textColor = .black
        return lb
    }()

    
    private var lookNewsLabel: UILabel = {
        let lb = UILabel()
        lb.text =  "소식 보기"
        lb.font = UIFont.boldSystemFont(ofSize: 15)
        lb.textColor = .black
        return lb
    }()
    
    private var lookNewsLabelDetail: UILabel = {
        let lb = UILabel()
        lb.text = "메인의 게시물이 게시되었을 때 소식을 알려줍니다."
        lb.font = UIFont.systemFont(ofSize: 13)
        lb.textColor = .lightGray
        return lb
    }()
    
    var lookNewsSwitch: UISwitch = {
        let st = UISwitch()
        st.setOn(false, animated: true)
        st.onTintColor = #colorLiteral(red: 0.9995557666, green: 0.8042631745, blue: 0.9328047037, alpha: 1)
        return st
    }()
    
    private var likeAlertLabel: UILabel = {
        let lb = UILabel()
        lb.text =  "좋아요 알림"
        lb.font = UIFont.boldSystemFont(ofSize: 15)
        lb.textColor = .black
        return lb
    }()
    
    private var likeAlertLabelDetail: UILabel = {
        let lb = UILabel()
        lb.text = "내 게시물에 좋아요가 달렸을 때 소식을 알려줍니다."
        lb.font = UIFont.systemFont(ofSize: 13)
        lb.textColor = .lightGray
        return lb
    }()
    
    var likeAlertSwitch: UISwitch = {
        let st = UISwitch()
        st.setOn(false, animated: true)
        st.onTintColor = #colorLiteral(red: 0.9995557666, green: 0.8042631745, blue: 0.9328047037, alpha: 1)
        return st
    }()
    
    private var voteAlertLabel: UILabel = {
        let lb = UILabel()
        lb.text =  "투표 알림"
        lb.font = UIFont.boldSystemFont(ofSize: 15)
        lb.textColor = .black
        return lb
    }()
    
    private var voteAlertLabelDetail: UILabel = {
        let lb = UILabel()
        lb.text = "내 게시물이 득표했을 떄 소식을 알려줍니다."
        lb.font = UIFont.systemFont(ofSize: 13)
        lb.textColor = .lightGray
        return lb
    }()
    
    var voteAlertSwitch: UISwitch = {
        let st = UISwitch()
        st.setOn(false, animated: true)
        st.onTintColor = #colorLiteral(red: 0.9995557666, green: 0.8042631745, blue: 0.9328047037, alpha: 1)
        return st
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
        [alertSettingLabel, lookNewsLabel, lookNewsLabelDetail, lookNewsSwitch, likeAlertLabel, likeAlertLabelDetail, likeAlertSwitch, voteAlertLabel, voteAlertLabelDetail, voteAlertSwitch].forEach{ addSubview($0)}
    }
    
    private func setConstraints() {
        alertSettingLabelConstraints()
        lookNewsLabelConstraints()
        lookNewsLabelDetailConstraints()
        lookNewsSwitchConstraints()
        likeAlertLabelConstraints()
        likeAlertLabelDetailConstraints()
        likeAlertSwitchConstraints()
        voteAlertLabelConstraints()
        voteAlertLabelDetailConstraints()
        voteAlertSwitchConstraints()
        
    }
    
    private func alertSettingLabelConstraints() {
        alertSettingLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            alertSettingLabel.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            alertSettingLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 0)
        ])
    }
    
    private func lookNewsLabelConstraints() {
        lookNewsLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            lookNewsLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 30),
            lookNewsLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -80),
            lookNewsLabel.topAnchor.constraint(equalTo: alertSettingLabel.bottomAnchor, constant: 50)
        ])
    }
    
    private func lookNewsLabelDetailConstraints() {
        lookNewsLabelDetail.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            
            lookNewsLabelDetail.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 30),
            lookNewsLabelDetail.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -80),
            lookNewsLabelDetail.topAnchor.constraint(equalTo: lookNewsLabel.bottomAnchor, constant: 6)
        ])
    }
    
    private func lookNewsSwitchConstraints() {
        lookNewsSwitch.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            
            lookNewsSwitch.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -5),
            lookNewsSwitch.leadingAnchor.constraint(equalTo: lookNewsLabelDetail.trailingAnchor, constant: 0),
            lookNewsSwitch.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 90)
        ])
    }
    
    private func likeAlertLabelConstraints() {
        likeAlertLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            likeAlertLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 30),
            likeAlertLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -80),
            likeAlertLabel.topAnchor.constraint(equalTo: lookNewsLabelDetail.bottomAnchor, constant: 50)
        ])
    }
    
    private func likeAlertLabelDetailConstraints() {
        likeAlertLabelDetail.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            likeAlertLabelDetail.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 30),
            likeAlertLabelDetail.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -80),
            likeAlertLabelDetail.topAnchor.constraint(equalTo: likeAlertLabel.bottomAnchor, constant: 6)
        ])
    }
    
    private func likeAlertSwitchConstraints() {
        likeAlertSwitch.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            likeAlertSwitch.leadingAnchor.constraint(equalTo: likeAlertLabelDetail.trailingAnchor, constant: 0),
            likeAlertSwitch.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -5),
            likeAlertSwitch.topAnchor.constraint(equalTo: lookNewsSwitch.bottomAnchor, constant: 65)
        ])
    }
    
    private func voteAlertLabelConstraints() {
        voteAlertLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            voteAlertLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 30),
            voteAlertLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -80),
            voteAlertLabel.topAnchor.constraint(equalTo: likeAlertLabelDetail.bottomAnchor, constant: 50)
        ])
    }
    
    private func voteAlertLabelDetailConstraints() {
        voteAlertLabelDetail.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            voteAlertLabelDetail.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 30),
            voteAlertLabelDetail.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -80),
            voteAlertLabelDetail.topAnchor.constraint(equalTo: voteAlertLabel.bottomAnchor, constant: 6)
        ])
    }
    
    private func voteAlertSwitchConstraints() {
        voteAlertSwitch.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            voteAlertSwitch.leadingAnchor.constraint(equalTo: voteAlertLabelDetail.trailingAnchor, constant: 0),
            voteAlertSwitch.topAnchor.constraint(equalTo: likeAlertSwitch.bottomAnchor, constant: 60),
            voteAlertSwitch.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -5)
        ])
    }
}

