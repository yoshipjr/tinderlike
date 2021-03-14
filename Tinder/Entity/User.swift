//
//  User.swift
//  Tinder
//
//  Created by 北原義久 on 2021/03/13.
//

import Foundation

struct User {
    let name: String?
    let email: String?
    let password: String?
    
    init(name: String?, email: String?, password: String?) {
        self.name = name
        self.email = email
        self.password = password
    }
}
