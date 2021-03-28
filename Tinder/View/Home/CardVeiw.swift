//
//  CardVeiw.swift
//  Tinder
//
//  Created by 北原義久 on 2021/03/03.
//

import Foundation
import UIKit

final class CardView: UIView {
    
    private let gradientLayer = CAGradientLayer()
    
    // MARK: UIView
    private let nopeLabel = CardInfoLabel(type: .nope)
    private let goodLabel = CardInfoLabel(type: .good)
    private let infoButton = UIButton(type: .system).createCardInfoButton()
    private let cardImageView = CardImageView(frame: .zero)
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 40, weight: .heavy)
        label.textColor = .white
        label.text = "Taro 22"
        return label
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
    
    init(user: User) {
        super.init(frame: .zero)
        
        setupLayout(user: user)
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panCardView))
        self.addGestureRecognizer(panGesture)
    }
    
    @objc private func panCardView(gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: self)
        guard let view = gesture.view else {
            return
        }
        // 動きがある場合の動き
        if gesture.state == .changed {
            self.handlePanChange(translation: translation)
        } else if gesture.state == .ended {
            // animationの記述方法を変更
//            UIView.animate(withDuration: 0.3) {
//                self.transform = .identity
//                self.layoutIfNeeded()
//            }
            self.handlePanEnded(view: view, translation: translation)
        }
    }
    
    private func setupGradientLayer() {
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradientLayer.locations = [0.3, 1.1]
        cardImageView.layer.addSublayer(gradientLayer)
    }
    
    override func layoutSubviews() {
        gradientLayer.frame = self.bounds
    }
    
    private func handlePanChange(translation: CGPoint) {
        let degree = translation.x / 20
        let angle = degree * .pi / 100 // .pi　円周率を取得するプロパティ
        let rotateTranslation = CGAffineTransform(rotationAngle: angle)
        self.transform = rotateTranslation.translatedBy(x: translation.x, y: translation.y)
        let ratio: CGFloat = 1 / 100
        let ratioValue = ratio * translation.x
        
        // 画像を右に動かすと、translationがプラスになって、左に動かすとーになる
        if translation.x > 100 {
            goodLabel.alpha = ratioValue
        } else if translation.x < 100 {
            nopeLabel.alpha = -ratioValue
        }
    }
    
    private func handlePanEnded(view: UIView, translation: CGPoint) {
//        let animation = UIViewPropertyAnimator(duration: 0.3, curve: .easeInOut) {
//            //元に戻す動き
//            self.transform = .identity
//        }
        if translation.x <= -120 {
            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.7, options: []) {

                let degree: CGFloat = -600 / 40
                let angle = degree * .pi / 180 // .pi　円周率を取得するプロパティ
                let rotateTranslation = CGAffineTransform(rotationAngle: angle)
                view.transform = rotateTranslation.translatedBy(x: -600, y: 100)
                self.layoutIfNeeded()

            } completion: { _ in
                self.removeFromSuperview()
            }

        } else if translation.x >= 120 {
            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.7, options: []) {

                let degree: CGFloat  = 600 / 40
                let angle = degree * .pi / 180 // .pi　円周率を取得するプロパティ
                let rotateTranslation = CGAffineTransform(rotationAngle: angle)
                self.transform = rotateTranslation.translatedBy(x: translation.x, y: 100)
                self.layoutIfNeeded()

            } completion: { _ in
                self.removeFromSuperview()
            }

        } else {
            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.7, options: []) {
                self.transform = .identity
                self.layoutIfNeeded()
                self.goodLabel.alpha = 0
                self.nopeLabel.alpha = 0
            }
        }
    }
    
    private func setupLayout(user: User) {
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

        // ユーザー情報ビューに反映
        nameLabel.text = user.name
        introductionLabel.text = user.email
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
