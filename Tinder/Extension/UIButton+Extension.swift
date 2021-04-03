//
//  UIButton+Extension.swift
//  Tinder
//
//  Created by 北原義久 on 2021/03/07.
//

import UIKit

extension UIButton {
    func createCardInfoButton() -> UIButton {
        self.setImage(UIImage(named: "comment_active"), for: .normal)
        self.tintColor = .white
        self.imageView?.contentMode = .scaleToFill
        return self
    }
}
