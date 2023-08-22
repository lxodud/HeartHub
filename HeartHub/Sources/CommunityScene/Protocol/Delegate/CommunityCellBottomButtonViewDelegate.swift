//
//  CommunityCellBottomButtonViewDelegate.swift
//  HeartHub
//
//  Created by 이태영 on 2023/07/19.
//

import Foundation

protocol CommunityCellBottomButtonViewDelegate: AnyObject {
    func didTapThumbButton()
    func didTapCommentButton()
    func didTapHeartButton()
}
