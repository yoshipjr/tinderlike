//
//  CardInfoLabel.swift
//  Tinder
//
//  Created by 北原義久 on 2021/03/06.
//

import Foundation
import UIKit

class CardInfoLabel: UILabel {
    
    enum Labeltype {
        case good
        case nope
        
        var name: String {
            switch self {
            case .good:
                return "GOOD"
            case .nope:
                return "NOPE"
            }
        }
        
        var color: UIColor {
            switch self {
            case .good:
                return .rgb(red: 137, green: 223, blue: 86)
            case .nope:
                return .rgb(red: 222, green: 110, blue: 110)
            }
        }
        
    }
    
    init(frame: CGRect, type: Labeltype) {
        super.init(frame: frame)
        setupLabel(type: type)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLabel(type: Labeltype) {
        font = .systemFont(ofSize: 45)
        text = type.name
        
        layer.borderWidth = 3
        layer.borderColor = type.color.cgColor
        layer.cornerRadius = 10
        alpha = 0
        
        textColor = type.color
        textAlignment = .center
    }
}
