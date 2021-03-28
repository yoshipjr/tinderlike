//
//  UIvew+Extension.swift
//  Tinder
//
//  Created by 北原義久 on 2021/03/03.
//

import UIKit

enum BorderPosition {
    case top, left, right, bottom
}

extension UIView {
    // それぞれ、viewの制約をどこに合わせるかを設定する
    func anchor(top: NSLayoutYAxisAnchor? = nil,
                bottom: NSLayoutYAxisAnchor? = nil,
                left: NSLayoutXAxisAnchor? = nil,
                right: NSLayoutXAxisAnchor? = nil,
                centerY: NSLayoutYAxisAnchor? = nil,
                centerX: NSLayoutXAxisAnchor? = nil,
                width: CGFloat? = nil,
                height: CGFloat? = nil,
                topPadding: CGFloat = 0,
                bottomPadding: CGFloat = 0,
                leftPadding: CGFloat = 0,
                rightPadding: CGFloat = 0) {
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            self.topAnchor.constraint(equalTo: top, constant: topPadding).isActive = true
        }
        
        if let bottom = bottom {
            self.bottomAnchor.constraint(equalTo: bottom, constant: -bottomPadding).isActive = true
        }
        
        if let centerY = centerY {
            self.centerYAnchor.constraint(equalTo: centerY).isActive = true
        }
        
        if let centerX = centerX {
            self.centerXAnchor.constraint(equalTo: centerX).isActive = true
        }
        
        if let left = left {
            self.leftAnchor.constraint(equalTo: left, constant: leftPadding).isActive = true
        }
        
        if let right = right {
            self.rightAnchor.constraint(equalTo: right, constant: -rightPadding).isActive = true
        }
        
        if let width = width {
            self.widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
        if let height = height {
            self.heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
    /// viewに枠線を表示する
    /// - Parameters:
    ///   - width: 太さ
    ///   - color: 色
    ///   - position: 場所
    func addBorder(width: CGFloat, color: UIColor, position: BorderPosition) {
        let border = CALayer()
        
        switch position {
        case .top:
            border.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: width)
            border.backgroundColor = color.cgColor
            self.layer.addSublayer(border)
        case .left:
            border.frame = CGRect(x: 0, y: 0, width: width, height: self.frame.height)
            border.backgroundColor = color.cgColor
            self.layer.addSublayer(border)
        case .right:
            border.frame = CGRect(x: self.frame.width - width, y: 0, width: width, height: self.frame.height)
            border.backgroundColor = color.cgColor
            self.layer.addSublayer(border)
        case .bottom:
            border.frame = CGRect(x: 0, y: self.frame.height - width, width: self.frame.width, height: width)
            border.backgroundColor = color.cgColor
            self.layer.addSublayer(border)
        }
    }
}

// MARK: animations
extension UIView {
    func removeCardViewAnimation(x: CGFloat) {
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.7, options: []) {

            let degree: CGFloat = x / 40
            let angle = degree * .pi / 180 // .pi　円周率を取得するプロパティ
            let rotateTranslation = CGAffineTransform(rotationAngle: angle)
            self.transform = rotateTranslation.translatedBy(x: x, y: 100)
            self.layoutIfNeeded()

        } completion: { _ in
            self.removeFromSuperview()
        }
    }
}
