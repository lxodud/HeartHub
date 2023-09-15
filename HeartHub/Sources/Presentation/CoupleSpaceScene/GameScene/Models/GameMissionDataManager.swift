//
//  MissionDataManager.swift
//  HeartHub
//
//  Created by 제민우 on 2023/08/03.
//

import UIKit

final class GameMissionDataManager {
    private var GameMissionDataArray: [String] = []
    
    func configureMissionData() {
        GameMissionDataArray = [
            "석촌호수 빨간 등대 앞에서 사진찍기",
            "애인 잘 때 얼굴에 낙서하기",
            "낭만 그 잡채. 자전거 타고 한강 데이트 가기 낭만 ",
            "폴라로이드 사진 찍고 폴꾸해보기"
        ]
    }
    
    func fetchGameMissionData() -> [String] {
        return GameMissionDataArray
    }
}
