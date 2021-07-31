//
//  ChatControllerViewModel.swift
//  ChatApp
//
//  Created by mac on 31/07/2021.
//

import Foundation
import Firebase

struct ChatControllerViewModel {
    
    func uploadMessage(_ message: String, to user: User, completion: ((Error?) -> Void)?) {
        guard let currentUid  = Auth.auth().currentUser?.uid else { return }
        let data = [ "text" : message,
                     "fromId" : currentUid,
                    "timestamp" : Timestamp(date: Date())
                ] as [String: Any]
        
        COLLECTION_MESSAGES.document(currentUid).collection(user.uid).addDocument(data: data) { _ in
            
            COLLECTION_MESSAGES.document(user.uid).collection(currentUid).addDocument(data: data, completion: completion)
            COLLECTION_MESSAGES.document(currentUid).collection("recent-messages").document(user.uid).setData(data)
            COLLECTION_MESSAGES.document(user.uid).collection("recent-messages").document(currentUid).setData(data)
            
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
