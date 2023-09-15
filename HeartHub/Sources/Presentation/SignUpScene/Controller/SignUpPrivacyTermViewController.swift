//
//  SignUpPrivacyTermViewController.swift
//  HeartHub
//
//  Created by 제민우 on 2023/08/14.
//

import UIKit

final class SignUpPrivacyTermViewController: UIViewController {
    
    private let privacyTermScrollView = SignUpPrivacyTermScrollView(privacyTermString:
    """
        HEART HUB(이하 ‘회사’라 함)는 개인정보보호법에 따라 HEART HUB 서비스(이하 '서비스'라 함)를 이용하고자 하시는 분께 수집하는 개인정보의 항목, 개인정보의 수집 및 이용목적, 개인정보의 보유 및 이용기간, 동의 거부권 및 동의거부시 불이익에 관한 사항을 다음과 같이 안내 드립니다. 이는 매우 중요한 사안이니 자세히 읽은 후 동의하여 주시기 바랍니다.

                - 수집하는 개인정보

        회사는 서비스 제공을 위하여, 회원가입시 또는 이용과정에서 이용자의 개인정보를 수집하고 있습니다.

        회원가입 시점에서 회사가 이용자로부터 수집하는 개인정보는 아래와 같습니다.
        회원 가입시에 ‘이메일 주소', ‘비밀번호’, ‘이름(또는 별명)', ‘성별', '생년월일', ‘애인과 사귀기 시작할 날짜’를 필수항목으로 수집합니다. 입력하신 생년월일이 만14세 미만인 경우, 회사는 회원가입 및 이용이 불가능하도록 조치하고 있습니다.

         서비스 이용 과정에서 이용자로부터 수집하는 개인정보는 아래와 같습니다.
        프로필(사진)을 등록하는 경우에 한하여 '프로필 사진’ 정보가 수집됩니다. 프로필 설정을 하지 않는 경우 해당 정보는 수집되지 않습니다.

        유료 서비스를 이용하는 경우에 한하여, '구매이력(구매아이템, 구매일시, 구매수단 등)'이 수집됩니다. 유료 서비스를 이용하지 않는 경우 해당 정보는 수집되지 않습니다.
        고객지원 서비스를 이용하는 경우에 한하여, 디바이스 정보(OS정보, 기종 및 모델명 등), 어플리케이션 버전 정보, 상담 내용이 수집될 수 있습니다. 고객지원 서비스를 이용하지 않는 경우 해당 정보는 수집되지 않습니다.

        서비스 이용 과정에서 생성되어 수집될 수 있는 정보는 아래와 같습니다.
        IP Address, 방문 일시(접속기록), 부정 이용 기록, 구매 이력, 디바이스 정보(이동통신사, OS 정보, 기종 및 모델명, 사용 언어, 기기 고유식별번호 등), 광고 식별자, 내부 식별자가 생성 및 수집될 수 있습니다.

                - 수집한 개인정보의 이용

        서비스의 회원관리, 서비스 개발/제공 및 향상, 안전한 인터넷 이용환경 구축 등 아래의 목적으로만 개인정보를 이용합니다.
        회원식별, 부정 이용방지와 비인가 사용방지, 가입의사 확인, 분쟁 조정을 위한 기록보존, 불만처리 등 민원처리, 고지사항 전달, 탈퇴의사 확인 등 회원 관리를 위하여 개인정보를 이용합니다.
        이메일 등 이용자가 설정한 연결수단으로 계정연결, HEART HUB서비스 제공을 위하여 개인정보를 이용합니다.
        신규 서비스 개발 및 마케팅·광고에 이용합니다.
        통계작성, 과학적 연구, 공익적 기록보존을 인공지능 분야 기술의 연구 개발 등을 위하여 이용하며, 이때는 반드시 가명처리하여 이용자의 프라이버시 침해가 없도록 조치하여 이용합니다.
        신규 서비스 개발 및 기존 서비스의 향상, 이용자에게 최적화한 맞춤 서비스의 제공을 위하여 개인정보를 이용합니다.
         통계학적 특성에 따른 서비스를 제공하고 광고를 게재하고, 이벤트 및 광고성 정보를 제공하고 이에 대한 참여기회를 제공하기 위하여 개인정보를 이용합니다.
        서비스의 유효성을 확인하고 접속빈도 파악 및 회원의 서비스 이용에 대한 통계를 산출하기위하여 개인정보를 이용합니다.

                - 개인정보의 보관 기간
        
        회사는 원칙적으로 이용자의 개인정보를 회원 탈퇴 시 지체없이 파기하고 있습니다.
        단, 이용자에게 개인정보 보관기간에 대해 별도의 동의를 얻은 경우 또는 법령에서 일정 기간 정보보관 의무를 부과하는 경우에는 해당 기간 동안 개인정보를 안전하게 보관합니다.
        또한, 연결 상대방과 관련된 각종 파기정책에 관하여는 이용약관 또는 연결 해제시 고지된 내용에 따릅니다. 한편, 부정/불량 이용 기록은 전화번호를 포함하여 1년간 보관합니다.

        전자상거래 등에서의 소비자 보호에 관한 법률, 전자문서 및 전자거래 기본법, 통신비밀보호법 등 법령에서 일정기간 정보의 보관을 규정하는 경우는 아래와 같습니다. 회사는 이 기간동안 법령의 규정에 따라 개인정보를 보관하며, 본 정보를 다른 목적으로는 절대 이용하지 않습니다.
                전자상거래 등에서자 보호에 관한 법률
                계약 또는 청약철회 등 소비에 관한 기록: 5년
                대금결제 및 재화 등의 공급에 관한 기록: 5년
                소비자의 불만 또는 분쟁처리에 관한 기록: 3년
                표시, 광고에 관한 기록 : 6개월
                통신비밀보호법
                로그인 기록: 3개월
                전자금융거래법
                전자금융 거래에 관한 기록 : 5년
                국세기본법, 소득세법
                세법이 규정하는 처리에 관한 기록 : 5년

        이용자는 개인정보의 수집 및 이용 동의를 거부할 권리가 있습니다. 회원가입시 수집하는 최소한의 최소한의 개인정보, 즉, 필수 항목에 대한 수집 및 이용 동의를 거부하실 경우, 회원가입 및 정상적인 서비스 이용이 어려울 수 있습니다. 위 내용은 소급하여 적용됩니다.

        더 자세한 내용은 개인정보처리방침을 참고하시기 바랍니다.
        """
    )
    
    private let headerView: UILabel = {
       let label = UILabel()
        label.text = "개인정보 수집 및 이용"
        label.font = UIFont(name: "Pretendard-SemiBold", size: 20)
        label.textAlignment = .center
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSubviews()
        configureLayout()
        view.backgroundColor = .white
    }
}

extension SignUpPrivacyTermViewController {
    private func configureSubviews() {
        
        [privacyTermScrollView, headerView].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    private func configureLayout() {
        let safeArea = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            // MARK: headerView Constraints
            headerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.07),
            headerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            headerView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            
            // MARK: privacyTermScrollView Constraints
            privacyTermScrollView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 15),
            privacyTermScrollView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            privacyTermScrollView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            privacyTermScrollView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
        ])
    }
}
