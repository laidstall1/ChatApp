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
    
    func uploadMessage(_ message: String, to user: User, completion: ((Error?) -> Void)?) {
        guard let currentUid  = Auth.auth().currentUser?.uid else { return }
        let data = [ "text" : message,
                     "fromId" : currentUid,
                    "timestamp" : Timestamp(date: Date())
                ] as [String: Any]
        
        COLLECTION_MESSAGES.document(currentUid).collection(user.uid).addDocument(data: data) { _ in
            COLLECTION_MESSAGES.document(user.uid).collection(currentUid).addDocument(data: data, completion: completion)
        }
    }
    
    func fetchMessages(forUser user: User, completion: @escaping ([Message]) -> Void ) {
        var messages = [Message]()
        guard let currentUid  = Auth.auth().currentUser?.uid else { return }
        
        let query = COLLECTION_MESSAGES.document(currentUid).collection(user.uid).order(by: "timestamp")
        query.addSnapshotListener { (snapshot, error) in
            snapshot?.documentChanges.forEach({ change in
                if change.type == .added {
                    let dictionary = change.document.data()
                    messages.append(Message(dictionary: dictionary))
                    completion(messages)
                }
            })
        }
    }
}
