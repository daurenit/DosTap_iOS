//
//  LoginViewModel.swift
//  DosTap_iOS
//
//  Created by Dauren on 06.05.2024.
//

import Foundation

class LoginViewModel: ObservableObject {
    
    var username: String = ""
    var password: String = ""
    
    func login() {
        
        Webservice().login(username: username, password: password) { result in
            switch result {
            case.success(let token):
                print(token)
            case.failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
