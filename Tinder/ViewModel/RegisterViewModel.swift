//
//  RegisterViewModel.swift
//  Tinder
//
//  Created by 北原義久 on 2021/03/07.
//

import Foundation
import RxSwift

class RegisterViewModel {
    
    private var disposebag = DisposeBag()
    // MARK: Observable
    var nameTextOuput = PublishSubject<String>()
    var emailTextOuput = PublishSubject<String>()
    var passwordTextOuput = PublishSubject<String>()
    
    var namtTextInput: AnyObserver<String> {
        nameTextOuput.asObserver()
    }
    
    var emailTextInput: AnyObserver<String> {
        emailTextOuput.asObserver()
    }
    
    var passwordTextInput: AnyObserver<String> {
        passwordTextOuput.asObserver()
    }
    
    init() {
        
        nameTextOuput.asObservable().subscribe { text in
            print("aaaaaaaaa", text)
        }.disposed(by: disposebag)
        
        emailTextOuput.asObservable().subscribe { text in
            print("aaaaaaaaa", text)
        }.disposed(by: disposebag)
        
        passwordTextOuput.asObservable().subscribe { text in
            print("aaaaaaaaa", text)
        }.disposed(by: disposebag)
    }
}
