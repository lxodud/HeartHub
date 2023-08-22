//
//  CommunityCellTransitionDelegate.swift
//  HeartHub
//
//  Created by 이태영 on 2023/07/19.
//

import Foundation

protocol CommunityCellTransitionDelegate: AnyObject {
    // MARK: Profile View Delegate
    func didTapUserProfile()
    func didTapPostOption()
    
    // MARK: Bottom Button View Delegate
    func didTapCommentButton(_ articleID: Int?)
}
