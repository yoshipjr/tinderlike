//
//  Firebase+Extension.swift
//  Tinder
//
//  Created by 北原義久 on 2021/03/13.
//

import Firebase
import FirebaseFirestore

extension Auth {
    
    static func createUserToFireAuth(email: String?, password: String?, name: String?, completion: @escaping (Bool) -> ()) {
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
            
            Firestore.setUserDataToFirestore(uid: uid, email: email, name: name) { result in
                completion(result)
            }
        }
    }

    static func loginWithFireAuth(email: String, password: String, completion: @escaping (Bool) -> Void) {

        Auth.auth().signIn(withEmail: email, password: password) { (res, err) in
            if let _ = err {
                print("ログインに失敗しました")
                completion(false)
                return
            }
            completion(true)
            print("ログインに成功")
        }
    }
}

extension Firestore {
    
    static func setUserDataToFirestore(uid: String, email: String, name: String?, completion: @escaping (Bool) -> ()) {
        
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
            completion(true)
            print("ユーザー情報の保存に成功")
        }
        
    }

    static  func fetchUserFromIFirestore(uid: String, completion: @escaping (User?) -> Void) {
        Firestore.firestore().collection("users").document(uid).getDocument { (snapshot, error) in
            if let error = error {
                print("ユーザー情報の取得に失敗", error)
                completion(nil)
                return
            }

            guard let data = snapshot?.data() else { return }
            let user = User.init(dic: data)
            completion(user)
        }
    }
}
