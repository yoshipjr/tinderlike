//
//  RegisterViewController.swift
//  Tinder
//
//  Created by 北原義久 on 2021/03/07.
//

import Foundation
import UIKit

class RegisterViewController: UIViewController {
    
    let nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "名前"
        textField.borderStyle = .roundedRect
        textField.font = .systemFont(ofSize: 14)
        return textField
    }()
    
    let registerButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("登録", for: .normal)
        button.backgroundColor = .red
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        
        let baseStackView = UIStackView(arrangedSubviews: [nameTextField, registerButton])
        view.addSubview(baseStackView)
        
        baseStackView.anchor(left: view.leftAnchor, right: view.rightAnchor, centerY: view.centerYAnchor, height: 200, leftPadding: 20, rightPadding: 20)
    }
}
