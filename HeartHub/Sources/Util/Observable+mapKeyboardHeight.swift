//
//  Observable+mappingKeyboardHeight.swift
//  HeartHub
//
//  Created by 이태영 on 2023/09/22.
//

import Foundation
import RxSwift

extension Observable where Element == Notification {
    func mapKeyboardHeight() -> Observable<CGFloat> {
       return self.compactMap({ $0.userInfo as? NSDictionary })
        .compactMap({ $0.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as? NSValue})
        .compactMap({ $0.cgRectValue.height })
    }
}
