//
//  RegisterTextField.swift
//  Tinder
//
//  Created by 北原義久 on 2021/03/07.
//

import Foundation
import UIKit

class RegisterTextField: UITextField {
    
    enum TextFieldType {
        case password
        case email
        case name
        
        var value: String {
            switch  self {
            case .password:
                return "パスワード"
            case .email:
                return "メールアドレス"
            case .name:
                return "名前"
            }
        }
    }
    
    init(frame: CGRect, type: TextFieldType) {
        super.init(frame: frame)
        self.placeholder = type.value
        self.borderStyle = .roundedRect
        self.font = .systemFont(ofSize: 14)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
