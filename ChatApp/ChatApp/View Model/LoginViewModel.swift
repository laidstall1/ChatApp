//
//  LoginViewModel.swift
//  ChatApp
//
//  Created by mac on 21/07/2021.
//

import Foundation

protocol AuthenticationProtocol {
    var formIsValid: Bool { get }
}

struct LoginViewModel {
    var email: String?
    var password: String?
    
    var formIsValid: Bool {
        return email?.isEmpty == false && password?.isEmpty == false 
    }
}
