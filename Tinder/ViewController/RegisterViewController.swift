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
import FirebaseFirestore

class RegisterViewController: UIViewController {
    private let disposeBag = DisposeBag()
    private let viewModel = RegisterViewModel()
    
    // MARK: UIView
    private let titleLabel: UILabel = RegisterTitleLabel(text: "Tinder")
    private let nameTextField: UITextField = RegisterTextField.init(frame: .zero, type: .name)
    private let emailTextField: UITextField = RegisterTextField.init(frame: .zero, type: .email)
    private let passwordTextField: UITextField = RegisterTextField.init(frame: .zero, type: .password)
    private let registerButton: UIButton = RegisterButton(text: "登録")
    private let alreadyHaveAcctountButton = UIButton(type: .system).createAboutAccountButton(title: "既にアカウントをお持ちの方はこちら")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupGradientLayer()
        setupLayout()
        setupBinding()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
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
        view.addSubview(alreadyHaveAcctountButton)
        
        nameTextField.anchor(height: 45)
        baseStackView.anchor(left: view.leftAnchor, right: view.rightAnchor, centerY: view.centerYAnchor, height: 200, leftPadding: 20, rightPadding: 20)
        titleLabel.anchor(bottom: baseStackView.topAnchor, centerX: view.centerXAnchor, bottomPadding: 20)
        alreadyHaveAcctountButton.anchor(top: baseStackView.bottomAnchor, centerX: view.centerXAnchor, topPadding: 10)
    }
    
    private func setupBinding() {
        // textFieldのbinding
        nameTextField.rx.text
            .asDriver()
            .drive { [weak self] text in
                self?.viewModel.nameTextInput.onNext(text ?? "")
                // textの情報ハンドル
            }
            .disposed(by: disposeBag)
        
        emailTextField.rx.text
            .asDriver()
            .drive { [weak self] text in
                self?.viewModel.emailTextInput.onNext(text ?? "")
                // textの情報ハンドル
            }
            .disposed(by: disposeBag)
        
        passwordTextField.rx.text
            .asDriver()
            .drive { [weak self] text in
                self?.viewModel.passwordTextInput.onNext(text ?? "")
                // textの情報ハンドル
            }
            .disposed(by: disposeBag)
        
        registerButton.rx.tap
            .asDriver()
            .drive { [weak self] _ in
                // 登録時の処理
                self?.createUser()
            }
            .disposed(by: disposeBag)
        
        //buttonのbindings
        alreadyHaveAcctountButton.rx.tap
            .asDriver()
            .drive{ [weak self] _ in
                let login = LoginViewController()
                self?.navigationController?.pushViewController(login, animated: true)
            }
            .disposed(by: disposeBag)
            
        // viewmodelのbinding
        viewModel.validRegisterDriver
            .drive { validAll in
                self.registerButton.isEnabled = validAll
                self.registerButton.backgroundColor = validAll ? .rgb(red: 227, green: 48, blue: 78) : .init(white: 0.7, alpha: 1)
            }
            .disposed(by: disposeBag)
    }
    
    private func createUser() {
        let user = User(name: nameTextField.text, email: emailTextField.text, password: nameTextField.text)
        Auth.createUserToFireAuth(email: emailTextField.text,
                                  password: passwordTextField.text,
                                  name: nameTextField.text) {  result in
            if result {
                print("処理が完了", result)
                self.dismiss(animated: true)
            } else {
                print("処理が失敗")
            }
        }
    }
}
