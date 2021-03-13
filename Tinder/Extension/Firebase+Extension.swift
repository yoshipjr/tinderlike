//
//  Firebase+Extension.swift
//  Tinder
//
//  Created by 北原義久 on 2021/03/13.
//

import Firebase

extension Auth {
    
    static func createUserToFireAuth(email: String?, password: String?, name: String?) {
        guard let email = email, let password = password else {
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
            
            Firestore.setUserDataToFirestore(uid: uid, email: email, name: name)
        }
    }
}

extension Firestore {
    
    static func setUserDataToFirestore(uid: String, email: String, name: String?) {
        
        guard let name = name else { return }
        let document = [
            "name" : name,
            "email" : email,
            "createdAt" : Timestamp()
        ] as [String : Any]
        
        Firestore.firestore().collection("users").document(uid).setData(document) {
            err in
            if let err = err {
                print("ユーザー情報の保存に失敗", err)
                return
            }
            print("ユーザー情報の保存に成功")
        }
    }
}
