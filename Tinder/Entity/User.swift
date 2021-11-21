//
//  User.swift
//  Tinder
//
//  Created by 北原義久 on 2021/03/13.
//

import Foundation
import Firebase

struct User {
    let name: String?
    let email: String?
    let createdAt: Timestamp?
    
    init(dic: [String: Any]) {
        self.name = dic["name"] as? String ?? ""
        self.email = dic["email"] as? String ?? ""
        self.createdAt = dic["createdAt"] as? Timestamp ?? Timestamp()
    }
}
