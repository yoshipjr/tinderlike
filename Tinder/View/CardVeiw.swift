//
//  CardVeiw.swift
//  Tinder
//
//  Created by 北原義久 on 2021/03/03.
//

import Foundation
import UIKit

final class CardView: UIView {
    
    let cardImageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .brown
        iv.layer.cornerRadius = 10
        iv.contentMode = .scaleToFill
        return iv
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 40, weight: .heavy)
        label.textColor = .white
        label.text = "Taro 22"
        return label
    }()
    
    let infoButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "comment_active"), for: .normal)
        button.tintColor = .white
        button.imageView?.contentMode = .scaleToFill
        return button
    }()
    
    let residenceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .regular)
        label.textColor = .white
        label.text = "Japan Osaka"
        return label
    }()
    
    let hobbyLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 25, weight: .regular)
        label.textColor = .white
        label.text = "running"
        return label
    }()
    
    let introductionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 25, weight: .regular)
        label.textColor = .white
        label.text = "I love running"
        return label
    }()
    
    let goodLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 45)
        label.text = "GOOD"
        
        label.layer.borderWidth = 3
        label.layer.borderColor = UIColor.rgb(red: 137, green: 223, blue: 86).cgColor
        label.layer.cornerRadius = 10
        
        label.textColor = UIColor.rgb(red: 137, green: 223, blue: 86)
        label.textAlignment = .center
        return label
    }()
    
    let nopeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 45)
        label.text = "NOPE"
        
        label.layer.borderWidth = 3
        label.layer.borderColor = UIColor.rgb(red: 222, green: 110, blue: 110).cgColor
        label.layer.cornerRadius = 10
        
        label.textColor = .rgb(red: 222, green: 110, blue: 110)
        label.textAlignment = .center
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupLayout()
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panCardView))
        self.addGestureRecognizer(panGesture)
    }
    
    @objc private func panCardView(gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: self)
        // 動きがある場合の動き
        if gesture.state == .changed {
            self.handlePanChange(translation: translation)
        } else if gesture.state == .ended {
            // animationの記述方法を変更
//            UIView.animate(withDuration: 0.3) {
//                self.transform = .identity
//                self.layoutIfNeeded()
//            }
            self.handlePanEnded()
        }
    }
    
    private func handlePanChange(translation: CGPoint) {
        let degree = translation.x / 20
        let angle = degree * .pi / 100 // .pi　円周率を取得するプロパティ
        let rotateTranslation = CGAffineTransform(rotationAngle: angle)
        self.transform = rotateTranslation.translatedBy(x: translation.x, y: translation.y)
//        self.transform = CGAffineTransform(translationX: translation.x, y: translation.y)
    }
    
    private func handlePanEnded() {
//        let animation = UIViewPropertyAnimator(duration: 0.3, curve: .easeInOut) {
//            //元に戻す動き
//            self.transform = .identity
//        }
        let animation = UIViewPropertyAnimator(duration: 1, dampingRatio: 0.5) {
            self.transform = .identity
        }
        animation.startAnimation()
    }
    
    private func setupLayout() {
        let infoVerticalStackview = UIStackView(arrangedSubviews: [residenceLabel, hobbyLabel, introductionLabel])
        infoVerticalStackview.axis = .vertical
        
        let baseStackView = UIStackView(arrangedSubviews: [infoVerticalStackview, infoButton])
        baseStackView.axis = .horizontal
        
        [
            cardImageView,
            nameLabel,
            baseStackView,
            goodLabel,
            nopeLabel
        ].forEach {
            addSubview($0)
        }
        
        cardImageView.anchor(top: topAnchor, bottom: bottomAnchor, left: leftAnchor, right: rightAnchor, leftPadding: 10, rightPadding: 10)
        infoButton.anchor(width: 40)
        baseStackView.anchor(bottom: cardImageView.bottomAnchor, left: cardImageView.leftAnchor, right: cardImageView.rightAnchor, bottomPadding: 20, leftPadding: 20, rightPadding: 20)
        nameLabel.anchor(bottom: baseStackView.topAnchor, left: cardImageView.leftAnchor, bottomPadding: 10, leftPadding: 20)
        goodLabel.anchor(top: cardImageView.topAnchor, left: cardImageView.leftAnchor, width: 140, height: 55, topPadding: 25, leftPadding: 20)
        nopeLabel.anchor(top: cardImageView.topAnchor, right: cardImageView.rightAnchor, width: 140, height: 55, topPadding: 25, rightPadding: 20)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
