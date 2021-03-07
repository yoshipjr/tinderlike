//
//  RegisterViewController.swift
//  Tinder
//
//  Created by 北原義久 on 2021/03/07.
//

import Foundation
import UIKit

class RegisterViewController: UIViewController {
    private let titleLabel: UILabel = RegisterTitleLabel()
    private let nameTextField: UITextField = RegisterTextField.init(frame: .zero, type: .name)
    private let emailTextField: UITextField = RegisterTextField.init(frame: .zero, type: .email)
    private let passwordTextField: UITextField = RegisterTextField.init(frame: .zero, type: .password)
    
    let registerButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("登録", for: .normal)
        button.backgroundColor = .red
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        
        let baseStackView = UIStackView(arrangedSubviews: [ nameTextField, emailTextField, passwordTextField, registerButton])
        baseStackView.axis = .vertical
        baseStackView.distribution = .fillEqually
        baseStackView.spacing = 20
        
        view.addSubview(baseStackView)
        view.addSubview(titleLabel)
        
        nameTextField.anchor(height: 45)
        baseStackView.anchor(left: view.leftAnchor, right: view.rightAnchor, centerY: view.centerYAnchor, height: 200, leftPadding: 20, rightPadding: 20)
        titleLabel.anchor(bottom: baseStackView.topAnchor, centerX: view.centerXAnchor, bottomPadding: 20)
    }
}
