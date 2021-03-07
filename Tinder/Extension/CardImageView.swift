//
//  CardImageView.swift
//  Tinder
//
//  Created by 北原義久 on 2021/03/07.
//

import Foundation
import UIKit

class  CardImageView: UIImageView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .brown
        self.layer.cornerRadius = 10
        self.contentMode = .scaleAspectFill
        self.clipsToBounds = true
        self.image = UIImage(named: "test_sample")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
