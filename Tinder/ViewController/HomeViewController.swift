//
//  ViewController.swift
//  Tinder
//
//  Created by 北原義久 on 2021/02/07.
//

// testuser testtest
// email test@testgmail.com
// password testtesttest

import UIKit
import FirebaseAuth
import FirebaseFirestore

class HomeViewController: UIViewController {
    
    private let logoutButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("ログアウト", for: .normal)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.¥
        self.view.backgroundColor = .white
        setupView()
        
        // autolayoutが表示される前に、画面を遷移させるようにすると、遷移がうまく以下なので、dispatchで処理を遅らせる
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }
        Firestore.fetchUserFromIFirestore(uid: uid)

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if Auth.auth().currentUser?.uid == nil {
            let registerController = RegisterViewController()
            let nav = UINavigationController(rootViewController: registerController)
            nav.modalPresentationStyle = .fullScreen
            self.present(nav, animated: true)
        }
    }

    private func setupView() {
        
        let topControlView = TopControlView()
        
        let cardView = CardView()
        let buttomControllView = BottomControllView()
        
        let views = [topControlView, cardView, buttomControllView]
        let stackView = UIStackView(arrangedSubviews: views)
        stackView.axis = .vertical
        self.view.addSubview(stackView)
        self.view.addSubview(logoutButton)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        [
            topControlView.heightAnchor.constraint(equalToConstant: 100),
            buttomControllView.heightAnchor.constraint(equalToConstant: 120),
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            stackView.leftAnchor.constraint(equalTo: view.leftAnchor),
            stackView.rightAnchor.constraint(equalTo: view.rightAnchor)].forEach { $0.isActive = true }
        
        logoutButton.anchor(bottom: view.bottomAnchor, left: view.leftAnchor, bottomPadding: 10, leftPadding: 10)
        
        logoutButton.addTarget(self, action:  #selector(tappedLogoutButton), for: .touchUpInside)
        
    }
    
    @objc private func tappedLogoutButton() {
        do {
            try Auth.auth().signOut()
            let registerController = RegisterViewController()
            let nav = UINavigationController(rootViewController: registerController)
            nav.modalPresentationStyle = .fullScreen
            self.present(nav, animated: true)
        } catch {
            print("ログアウトに失敗", error)
        }
        
    }
}

