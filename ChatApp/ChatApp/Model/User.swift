//
//  User.swift
//  ChatApp
//
//  Created by mac on 23/07/2021.
//

import Foundation

struct User {
    let uid, profileImageURL, username, email, fullname : String

    init(dictionary: [String: Any]) {
        self.uid = dictionary["uid"] as? String ?? ""
        self.profileImageURL = dictionary["profileImageUrl"] as? String ?? ""
        self.username = dictionary["username"] as? String ?? ""
        self.email = dictionary["email"] as? String ?? ""
        self.fullname = dictionary["fullName"] as? String ?? ""
    }
}
