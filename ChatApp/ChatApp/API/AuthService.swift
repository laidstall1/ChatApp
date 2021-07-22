//
//  AuthService.swift
//  ChatApp
//
//  Created by mac on 22/07/2021.
//

import Foundation
import Firebase

struct RegistrationCredentials {
    let email, password, fullName, username: String
    let profileImage: UIImage
}

struct AuthService {
    
    static let shared = AuthService()
    
    func logUserIn(withEmail email: String, _ password: String, completion: AuthDataResultCallback? ) {
        
        Auth.auth().signIn(withEmail: email, password: password, completion: completion)
    }
    
    func createUser(with credentials: RegistrationCredentials, completion: ((Error?) -> Void)?) {
        guard let imageData = credentials.profileImage.jpegData(compressionQuality: 0.3) else { return }
        
        let filename = NSUUID().uuidString
        let ref = Storage.storage().reference(withPath: "/profile_images/\(filename)")
        
        // upload image file from disk
        ref.putData(imageData, metadata: nil) { (meta, error) in
            if let error = error {
                print("DEBUG: failed to upload image with error: \(error.localizedDescription)")
                return
            }
            // download image url
            ref.downloadURL { (url, error) in
                guard let profileImageUrl = url?.absoluteString else { return }
                
                // create new user
                Auth.auth().createUser(withEmail: credentials.email, password: credentials.password) { result, error in
                    if let error = error {
                        print("DEBUG: failed to create user with error: \(error.localizedDescription)")
                        return
                    }
                    // unwrap the uid
                    guard let uid = result?.user.uid else { return }
                    
                    // create a dictionary with the textfields
                    let data = [ "email" : credentials.email,
                                 "fullName" : credentials.fullName,
                                 "profileImageUrl" : profileImageUrl,
                                 "uid" : uid,
                                 "username" : credentials.username ] as [String : Any]
                    
                    // upload document data
                    Firestore.firestore().collection("users").document(uid).setData(data, completion: completion)
                }
            }
        }
    }
}
