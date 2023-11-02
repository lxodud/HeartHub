//
//  GameClearMissionDataManager.swift
//  HeartHub
//
//  Created by 제민우 on 2023/08/05.
//

import UIKit

final class GameClearMissionDataManager {
    private var GameClearMissionDataArray: [String] = []
    
    func configureMissionData() {
        GameClearMissionDataArray = [
            "(승자없는) 요리대결",
            "드디어 열었다.마루는 강쥐 팝업스튜디오 다녀오기",
            "우리 동네에 이런곳이?! 맛집깨기. 공방가서 우리의 커플 공예품 만들기 ",
            "여름이다.. 세일도 하겠다 캐리비안베이 가보자고"
        ]
    }
    
    func fetchGameMissionData() -> [String] {
        return GameClearMissionDataArray
    }
}
