//
//  SignUp3ViewController.swift
//  test
//
//  Created by 제민우 on 2023/07/08.
//


import UIKit

final class SignUpTermAgreeViewController: UIViewController {

    private let signUpTermAgreeView = SignUpTermAgreeView()
    private let userInformationManager: SignUpManager
    
    private let signUpTermTableView = UITableView()
    // 약관동의 사이 선
    private var lineView: UIView = {
        let line = UIView()
        line.backgroundColor = #colorLiteral(red: 0.7686274648, green: 0.7686274648, blue: 0.7686274648, alpha: 1)
        return line
    }()
    
    private lazy var footerSpacingView: UIView = {
       let view = UIView()
        view.backgroundColor = .white
        view.addSubview(lineView)
        return view
    }()
    
    private let termDescriptionsLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont(name: "Pretendard-Regular", size: 14)
        label.text = """
        HeartHuB 서비스를 이용하기 위해서는 만 14세 이상이 되어야 합니다. 만 14세 미만의 이용자일 경우 이용이 제한됩니다.
        
        개인정보의 마케팅 활용(마케팅 및 광고성 정보 전송)에 동의하지 않으실 수 있으며, 동의하지 않으시더라도 HeartHuB 서비스를 이용하실 수 있습니다.
        """
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 0
        label.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        return label
    }()

    private let termsArray = [
        "약관 전체 동의",
        "(필수) 만 14세 이상입니다.",
        "(필수) 개인정보 수집 및 이용동의",
        "(필수) 이용 약관 동의",
        "(선택) 마케팅 활용 동의"
    ]
    
    private var termAgreeButtonStates: [Int: Bool] = [:]
    
    init(userInformationManager: SignUpManager) {
        self.userInformationManager = userInformationManager
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = signUpTermAgreeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureAddTarget()
        tableViewInitialSetting()
        configureSubViews()
        configureLayout()
        signUpTermAgreeView.createAccountButton.isEnabled = false
    }
}

// MARK: TableView Delegate Implement
extension SignUpTermAgreeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section == 0 {
            return footerSpacingView
        }
        return nil
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 0 {
            let footerHeight = signUpTermTableView.rowHeight
            return footerHeight
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let rowHeight = tableView.frame.height / CGFloat(termsArray.count + 1)
        return rowHeight
    }
}

// MARK: TableView DataSource Implement
extension SignUpTermAgreeViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section == 1 {
            return 1
        } else if section == 2 {
            return 2
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: SignUpTermTableViewCell.reuseIdentifier,
            for: indexPath) as? SignUpTermTableViewCell else {
                return UITableViewCell()
            }
        cell.selectionStyle = .none
        
        // termDescriptionButton 구성
        if indexPath.section == 0 {
            cell.termLabel.text = termsArray[indexPath.row]
            cell.termDescriptionButton.isHidden = true
        } else if indexPath.section == 1 {
            cell.termLabel.text = termsArray[indexPath.row + 1]
            cell.termDescriptionButton.isHidden = true
        } else if indexPath.section == 2 {
            cell.termLabel.text = termsArray[indexPath.row + 2]
        } else {
            cell.termLabel.text = termsArray[indexPath.row + 4]
            cell.termDescriptionButton.isHidden = true
        }
        
        // termAgreeButton 이벤트 처리
        cell.termAgreeButton.tag = indexPath.section
        cell.termAgreeButton.addTarget(self, action: #selector(termAgreeButtonTapped(sender:)), for: .touchUpInside)
        
        // termDiscriptionButton 이벤트 처리
        cell.termDescriptionButton.tag = indexPath.row
        cell.termDescriptionButton.addTarget(self, action: #selector(termDescriptionButtonTapped(sender:)), for: .touchUpInside)

        return cell
    }
}

// MARK: TableView InitialSetting
extension SignUpTermAgreeViewController {
    private func tableViewInitialSetting() {
        signUpTermTableView.delegate = self
        signUpTermTableView.dataSource = self
        signUpTermTableView.register(
            SignUpTermTableViewCell.self,
            forCellReuseIdentifier: SignUpTermTableViewCell.reuseIdentifier)
        signUpTermTableView.isScrollEnabled = false
        signUpTermTableView.separatorStyle = .none
        
        for key in 0..<5 {
            termAgreeButtonStates[key] = false
        }
    }
}

// MARK: Configure Layout
extension SignUpTermAgreeViewController {
    private func configureSubViews() {
        [signUpTermTableView, termDescriptionsLabel].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        lineView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configureLayout() {
        let safeArea = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            // MARK: signUpTermTableView Constraints
            signUpTermTableView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signUpTermTableView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 166),
            signUpTermTableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -357),
            signUpTermTableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 33),

            // MARK: lineView Constraints
            lineView.heightAnchor.constraint(equalToConstant: 1),
            lineView.centerYAnchor.constraint(equalTo: footerSpacingView.centerYAnchor),
            lineView.leadingAnchor.constraint(equalTo: footerSpacingView.leadingAnchor),
            lineView.trailingAnchor.constraint(equalTo: footerSpacingView.trailingAnchor),
            
            termDescriptionsLabel.topAnchor.constraint(equalTo: signUpTermTableView.bottomAnchor),
            termDescriptionsLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            termDescriptionsLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 70),
            termDescriptionsLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -33)
        ])
    }
}

// MARK: Configure AddTarget
extension SignUpTermAgreeViewController {
    private func configureAddTarget() {
        signUpTermAgreeView.createAccountButton.addTarget(self, action: #selector(didTapCreateAccountButton), for: .touchUpInside)
        signUpTermAgreeView.signUpTermAgreePreviousPageButton.addTarget(self, action: #selector(didTapsignUpTermAgreePreviousPageButton), for: .touchUpInside)
    }
    
    @objc private func didTapCreateAccountButton() {
        // MARK: 계정생성 버튼 누를 시 동작 지정
        userInformationManager.join {
            DispatchQueue.main.async {
                self.navigationController?.popToRootViewController(animated: true)
            }
        }
    }
    
    @objc private func didTapsignUpTermAgreePreviousPageButton() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func termAgreeButtonTapped(sender: UIButton) {
        // 필수 버튼 미선택시 계정생성 버튼 비활성화
        switch sender.tag {
        case 0:
            let allTermAgreed = sender.isSelected
            for key in 1...3 {
                termAgreeButtonStates[key] = allTermAgreed
            }
            for s in 1...3 {
                for r in 0...1 {
                    if let cell = signUpTermTableView.cellForRow(at: IndexPath(row: r, section: s)) as? SignUpTermTableViewCell {
                        cell.termAgreeButton.isSelected = allTermAgreed
                    }
                }
            }
            if let cell = signUpTermTableView.cellForRow(at: IndexPath(row: 2, section: 1)) as? SignUpTermTableViewCell {
                cell.termAgreeButton.isSelected = allTermAgreed
            }
        case 1...3:
            termAgreeButtonStates[sender.tag] = sender.isSelected
        default:
            termAgreeButtonStates[sender.tag] = false
        }
        
        let essentialButtonSelected = (1...2).allSatisfy({termAgreeButtonStates[$0] == true})
        signUpTermAgreeView.createAccountButton.isEnabled = essentialButtonSelected
        
        // 전체 동의 로직
        let allTermAgreeButtonSelected = (1...3).allSatisfy({termAgreeButtonStates[$0] == true})
        
        if let cell = signUpTermTableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? SignUpTermTableViewCell {
            cell.termAgreeButton.isSelected = allTermAgreeButtonSelected
        }
        userInformationManager.marketingStatus = termAgreeButtonStates[3]
    }
    
    @objc func termDescriptionButtonTapped(sender: UIButton) {
        if sender.tag == 0 {
            let privacyTermViewController = SignUpPrivacyTermViewController()
            privacyTermViewController.modalPresentationStyle = .overFullScreen
            present(privacyTermViewController, animated: true, completion: nil)
        } else {
            let termOfUseViewController = SignUpTermOfUseViewController()
            termOfUseViewController.modalPresentationStyle = .overFullScreen
            present(termOfUseViewController, animated: true, completion: nil)
        }
    }
}
