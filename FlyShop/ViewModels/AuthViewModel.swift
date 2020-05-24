//
//  AuthViewModel.swift
//  FlyShop
//
//  Created by Karen Mirakyan on 5/5/20.
//  Copyright © 2020 Karen Mirakyan. All rights reserved.
//

import Foundation

class AuthViewModel: ObservableObject {
    @Published var userLogged: Bool = false
    @Published var number: String = ""
    @Published var confirmationCode: String = ""
    @Published var showLoading: Bool = false
    
    func signUp() {
        AuthService().signUp(phoneNumber: self.number)
    }
    
    func logTheUser() {
        self.showLoading = true
        AuthService().signIn(verificationCode: self.confirmationCode) { (result) in
            if result == true {
                self.showLoading = false
                self.userLogged = true
            }
        }
    }
}
