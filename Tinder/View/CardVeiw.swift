//
//  CardVeiw.swift
//  Tinder
//
//  Created by 北原義久 on 2021/03/03.
//

import Foundation
import UIKit

final class CardView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .green
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
