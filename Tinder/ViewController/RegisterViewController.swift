//
//  RegisterViewController.swift
//  Tinder
//
//  Created by 北原義久 on 2021/03/07.
//

import Foundation
import UIKit
import RxSwift
import FirebaseAuth

class RegisterViewController: UIViewController {
    private let disposeBag = DisposeBag()
    
    // MARK: UIView
    private let titleLabel: UILabel = RegisterTitleLabel()
    private let nameTextField: UITextField = RegisterTextField.init(frame: .zero, type: .name)
    private let emailTextField: UITextField = RegisterTextField.init(frame: .zero, type: .email)
    private let passwordTextField: UITextField = RegisterTextField.init(frame: .zero, type: .password)
    private let registerButton: UIButton = RegisterButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupGradientLayer()
        setupLayout()
        setupBinding()
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
    
    private func setupBinding() {
        nameTextField.rx.text.asDriver().drive { [weak self] text in
            // text情報のハンドル
            
        }.disposed(by: disposeBag)
        
        emailTextField.rx.text.asDriver().drive { [weak self] text in
            // text情報のハンドル
            
        }.disposed(by: disposeBag)
        
        passwordTextField.rx.text.asDriver().drive { [weak self] text in
            // text情報のハンドル
            
        }.disposed(by: disposeBag)
        
        registerButton.rx.tap.asDriver().drive { [weak self]_ in
            self?.createUserToFireAuth()
        }.disposed(by: disposeBag)

    }
    
    private func createUserToFireAuth() {
        guard let email = emailTextField.text, let password = passwordTextField.text else {
            return
        }
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            if let error = error {
                print("auth情報の保存に失敗", error)
                return
            }
            
            guard let uid = result?.user.uid else {
                return
            }
            
            print("auth情報の保存に成功しました", uid)
        }
    }
}
