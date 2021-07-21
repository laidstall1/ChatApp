//
//  SignUpViewModel.swift
//  ChatApp
//
//  Created by mac on 21/07/2021.
//

import Foundation

struct SignUpViewModel: AuthenticationProtocol {
    var email: String?
    var fullName: String?
    var userName: String?
    var password: String?
    
    var formIsValid: Bool {
        return (email?.isEmpty == false
                    && fullName?.isEmpty == false
                    && userName?.isEmpty == false
                    && password?.isEmpty == false)
    }
}
