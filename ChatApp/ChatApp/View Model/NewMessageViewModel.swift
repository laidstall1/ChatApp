//
//  NewMessageViewModel.swift
//  ChatApp
//
//  Created by mac on 23/07/2021.
//
import Firebase
import Foundation

class NewMessageViewModel {
    
    var users = [User]()
    
    func fetchUsers(completion: @escaping () -> Void) {
        Firestore.firestore().collection("users").getDocuments { snapshot, error in
            snapshot?.documents.forEach({ document in
                let dictionary = document.data()
                let user = User(dictionary: dictionary)
                self.users.append(user)
                completion()
            })
        }
    }
}
