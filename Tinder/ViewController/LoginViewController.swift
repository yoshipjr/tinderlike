//
//  LoginViewController.swift
//  Tinder
//
//  Created by 北原義久 on 2021/03/14.
//

import UIKit
import RxSwift

class LoginViewController: UIViewController {
    
    private let disposebag = DisposeBag()
    
    // MARK: UIView
    private let titleLabel: UILabel = RegisterTitleLabel(text: "Login")
    private let nameTextField: UITextField = RegisterTextField.init(frame: .zero, type: .name)
    private let emailTextField: UITextField = RegisterTextField.init(frame: .zero, type: .email)
    private let passwordTextField: UITextField = RegisterTextField.init(frame: .zero, type: .password)
    private let registerButton: UIButton = RegisterButton(text: "ログイン")
    private let dontHaveAcctountButton = UIButton(type: .system).createAboutAccountButton(title: "アカウントをお持ちでない方はこちら")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupGradientLayer()
        setupLayout()
        setupBindings()
    }
    
    private func setupGradientLayer() {
        let layer = CAGradientLayer()
        let startColor = UIColor.rgb(red: 227, green: 48, blue: 78).cgColor
        let endColor = UIColor.rgb(red: 245, green: 208, blue: 108).cgColor
        
        layer.colors = [startColor, endColor]
        layer.locations = [0.0, 1.3]
        
        layer.frame = view.bounds
        view.layer.addSublayer(layer)
    }
    
    private func setupLayout() {
        let baseStackView = UIStackView(arrangedSubviews: [ emailTextField, passwordTextField, registerButton])
        baseStackView.axis = .vertical
        baseStackView.distribution = .fillEqually
        baseStackView.spacing = 20
        
        view.addSubview(baseStackView)
        view.addSubview(titleLabel)
        view.addSubview(dontHaveAcctountButton)
        
        emailTextField.anchor(height: 45)
        baseStackView.anchor(left: view.leftAnchor, right: view.rightAnchor, centerY: view.centerYAnchor, height: 200, leftPadding: 20, rightPadding: 20)
        titleLabel.anchor(bottom: baseStackView.topAnchor, centerX: view.centerXAnchor, bottomPadding: 20)
        dontHaveAcctountButton.anchor(top: baseStackView.bottomAnchor, centerX: view.centerXAnchor, topPadding: 10)
    }
    
    private func setupBindings() {
        dontHaveAcctountButton.rx.tap.asDriver().drive { [weak self] _ in
            self?.navigationController?.popViewController(animated: true)
        }.disposed(by: disposebag)
    }
}
