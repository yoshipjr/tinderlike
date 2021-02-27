//
//  TopControllView.swift
//  Tinder
//
//  Created by 北原義久 on 2021/02/14.
//

import UIKit
import RxCocoa
import RxSwift

class TopControlView: UIView {
    private let disposeBag =  DisposeBag()
    
    struct Const {
        static let selected = "selected"
        static let unselected = "unselected"
    }
    
    enum ImageName {
        case tinder
        case good
        case comment
        case profile
        var value: [String : String] {
            switch self {
            case .tinder:
                return [Const.selected : "tinder_active", Const.unselected : "tinder_noactive"]
            case .good:
                return [Const.selected : "diamond_active", Const.unselected : "diamond_noactive"]
            case .comment:
                return [Const.selected : "comment_active", Const.unselected : "comment_nonactive"]
            case .profile:
                return [Const.selected : "profile_active",  Const.unselected : "profile_noactive"]
            }
        }
    }
    
    let tinderButton = createTopButton(imageName: .tinder)
    let goodButton = createTopButton(imageName: .good)
    let commentButton = createTopButton(imageName: .comment)
    let profileButton = createTopButton(imageName: .profile)
    
    static private func createTopButton(imageName: ImageName ) -> UIButton {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: imageName.value[Const.selected] ?? ""), for: .selected)
        button.setImage(UIImage(named: imageName.value[Const.unselected] ?? ""), for: .normal)
        return button
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        setupBindings()
        tinderButton.isSelected = true
    }
    
    private func setupLayout() {
        let stackView = UIStackView(arrangedSubviews: [tinderButton, goodButton, commentButton, profileButton])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 40
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
            
        [
        stackView.topAnchor.constraint(equalTo: topAnchor),
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
        stackView.leftAnchor.constraint(equalTo: leftAnchor, constant: 40),
        stackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -40)
        ].forEach { $0.isActive = true }
    }
    
    private func setupBindings() {
        tinderButton.rx.tap.subscribe { _ in
            self.handleSelectedButton(selctedButton: self.tinderButton)
        }
        .disposed(by: disposeBag)
        
        goodButton.rx.tap.subscribe { _ in
            self.handleSelectedButton(selctedButton: self.goodButton)
        }
        .disposed(by: disposeBag)
        
        commentButton.rx.tap.subscribe { _ in
            self.handleSelectedButton(selctedButton: self.commentButton)
        }
        .disposed(by: disposeBag)
        
        profileButton.rx.tap.subscribe { _ in
            self.handleSelectedButton(selctedButton: self.profileButton)
        }
        .disposed(by: disposeBag)
    }
    
    private func handleSelectedButton(selctedButton: UIButton) {
        
        let buttons = [tinderButton, goodButton, commentButton, profileButton]
        
        buttons.forEach { button in
            if button == selctedButton {
                button.isSelected = true
                if button == commentButton {
                    let vc = UIViewController()
                }
            } else {
                button.isSelected = false
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
