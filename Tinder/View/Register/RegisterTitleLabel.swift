//
//  RegisterTitleLabel.swift
//  Tinder
//
//  Created by 北原義久 on 2021/03/07.
//

import UIKit

class RegisterTitleLabel: UILabel {
    
    init() {
        super.init(frame: .zero)
        self.text = "Tinder"
        self.backgroundColor = .clear
        self.font = .boldSystemFont(ofSize: 60)
        self.textColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
