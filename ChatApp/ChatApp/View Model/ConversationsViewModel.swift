//
//  ConversationsViewModel.swift
//  ChatApp
//
//  Created by mac on 31/07/2021.
// 

import Foundation
import Firebase

struct ConversationsViewModel {
    
    func fetchUser(withUid uid: String, completion: @escaping(User) -> Void) {
        COLLECTION_USERS.getDocuments { snapshot , error in
            snapshot?.documents.forEach({ document in
                let dictionary = document.data()
                let user = User(dictionary: dictionary)
                completion(user)
            })
        }
    }
    
    func fetchConversations(completion: @escaping ([Conversation]) -> Void) {
        var conversations = [Conversation]()
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        let query = COLLECTION_MESSAGES.document(currentUid).collection("recent-messages").order(by: "timestamp")
        query.addSnapshotListener { snapshot, error in
            snapshot?.documentChanges.forEach({ change in
                let dictionary = change.document.data()
                let message = Message(dictionary: dictionary)
                
                self.fetchUser(withUid: message.toId) { user in
                    let conversation = Conversation(user: user, message: message)
                    conversations.append(conversation)
                    completion(conversations)
                }
            })
        }
    }
}
