//
//  BottomControllView.swift
//  Tinder
//
//  Created by 北原義久 on 2021/02/14.
//

import Foundation
import UIKit

class BottomControllView: UIView {
    
    let reloadView = BottomButtonView(frame: .zero, width: .small, imageName: .star)
    let cancelview = BottomButtonView(frame: .zero, width: .midium, imageName: .cancel)
    let suparlikeView = BottomButtonView(frame: .zero, width: .small, imageName: .home)
    let likeView = BottomButtonView(frame: .zero, width: .midium, imageName: .good)
    let boostView = BottomButtonView(frame: .zero, width: .small, imageName: .star)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let views = [reloadView, cancelview, suparlikeView, likeView, boostView]
        let stackView = UIStackView(arrangedSubviews: views)
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
            
        [
        stackView.topAnchor.constraint(equalTo: topAnchor),
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
        stackView.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
        stackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -10)
        ].forEach { $0.isActive = true }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class BottomButtonView: UIView {
    
    var button: ButtomButton?
    
    enum Width: CGFloat {
        case small
        case midium
        
        var value: CGFloat {
            switch self {
            case .small:
                return 50
            case .midium:
                return 60
            }
        }
    }
    
    enum ImageName: String {
        case cancel
        case heart
        case home = "home_icon_seleceted"
        case good = "thumbs_goog"
        case star
    }
    
    init(frame: CGRect, width: Width, imageName: ImageName) {
        super.init(frame: frame)
        
        button = ButtomButton(type: .custom)
        button?.setImage(UIImage(named: imageName.rawValue)?.resize(size: .init(width: width.value * 0.4, height: width.value * 0.4)), for: .normal)
//        button?.setTitle("top", for: .normal)
        button?.setTitleColor(.black, for: .normal)
        button?.translatesAutoresizingMaskIntoConstraints = false
        button?.backgroundColor = .white
        button?.layer.cornerRadius = width.value / 2
        button?.layer.shadowOffset = .init(width: 1.5, height: 2)
        button?.layer.shadowColor = UIColor.black.cgColor
        button?.layer.shadowOpacity = 0.3
        button?.layer.shadowRadius = 15
        guard let button = button else { return }
        addSubview(button)
        
        [button.centerYAnchor.constraint(equalTo: centerYAnchor),
         button.centerXAnchor.constraint(equalTo: centerXAnchor),
        button.widthAnchor.constraint(equalToConstant: 50),
        button.heightAnchor.constraint(equalToConstant: 50)].forEach {
            $0?.isActive = true
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class ButtomButton: UIButton {
    
    override var isHighlighted: Bool {
        didSet {
            if isHighlighted {
                UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: []) {
                    self.transform = .init(scaleX: 0.8, y: 0.8)
                    self.layoutIfNeeded()
                }
            } else {
                UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: []) {
                    self.transform = .identity
                    self.layoutIfNeeded()
                }
            }
            
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
