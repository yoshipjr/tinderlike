//
//  RegisterTitleLabel.swift
//  Tinder
//
//  Created by 北原義久 on 2021/03/07.
//

import UIKit

class RegisterTitleLabel: UILabel {
    
    init(text: String) {
        super.init(frame: .zero)
        self.text = text
        self.backgroundColor = .clear
        self.font = .boldSystemFont(ofSize: 60)
        self.textColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
