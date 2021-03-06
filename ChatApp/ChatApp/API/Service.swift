//
//  Service.swift
//  ChatApp
//
//  Created by mac on 23/07/2021.
//
import Firebase
import Foundation

struct Service {
    
    static func fetchUsers(completion: @escaping () -> Void ) {
        var users = [User]()
        Firestore.firestore().collection("users").getDocuments { snapshot, error in
            snapshot?.documents.forEach({ document in
                let dictionary = document.data()
                let user = User(dictionary: dictionary)
                users.append(user)
                completion()
            })
        }
    }
}
