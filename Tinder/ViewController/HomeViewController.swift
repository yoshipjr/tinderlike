//
//  ViewController.swift
//  Tinder
//
//  Created by 北原義久 on 2021/02/07.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.¥
        self.view.backgroundColor = .white
        setupView()
        
        // autolayoutが表示される前に、画面を遷移させるようにすると、遷移がうまく以下なので、dispatchで処理を遅らせる
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            let registerController = RegisterViewController()
            registerController.modalPresentationStyle = .fullScreen
            self.present(registerController, animated: true)
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
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        [
            topControlView.heightAnchor.constraint(equalToConstant: 100),
            buttomControllView.heightAnchor.constraint(equalToConstant: 120),
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            stackView.leftAnchor.constraint(equalTo: view.leftAnchor),
            stackView.rightAnchor.constraint(equalTo: view.rightAnchor)].forEach { $0.isActive = true }
    }
}

