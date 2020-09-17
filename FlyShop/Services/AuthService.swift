//
//  AuthService.swift
//  FlyShop
//
//  Created by Karen Mirakyan on 5/5/20.
//  Copyright © 2020 Karen Mirakyan. All rights reserved.
//

import Foundation
import Firebase

class AuthService {
    func signUp( phoneNumber: String ) {
                
        PhoneAuthProvider.provider().verifyPhoneNumber("+374\(phoneNumber)", uiDelegate: nil) { (verificationID, error) in
            if error != nil {
                print(error?.localizedDescription ?? "Error occured")
                return
            }
            
            UserDefaults.standard.set( verificationID!, forKey: "authVerificationID")
        }
    }
    
    func signIn( verificationCode: String, completion: @escaping ( Bool ) -> () ) {
        let verificationID = UserDefaults.standard.string(forKey: "authVerificationID")
        if verificationID == nil {
            DispatchQueue.main.async {
                completion( false )
            }
            return
        }
        let credential =  PhoneAuthProvider.provider().credential(withVerificationID: verificationID!, verificationCode: verificationCode)

        
        Auth.auth().signIn(with: credential) { (result, error) in
            if error != nil {
                DispatchQueue.main.async {
                    completion( false )
                    print(error?.localizedDescription ?? "Error occured")
                }
                return
            }
            
            DispatchQueue.main.async {
                completion( true )
            }

        }
    }
}
