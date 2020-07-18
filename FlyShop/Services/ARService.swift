//
//  ARService.swift
//  FlyShop
//
//  Created by Karen Mirakyan on 7/18/20.
//  Copyright © 2020 Karen Mirakyan. All rights reserved.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift
import FirebaseStorage

class ARService {
    
    func fetchARProduct() {

        let storage = Storage.storage().reference().child("AR Products/toy_biplane.usdz")
                
        let localURL = URL(string: "FlyShop/Views/AR/Models/")!
        
        storage.write(toFile: localURL) { (url, error) in
            if error != nil {
                print("---------------\(error?.localizedDescription)")
            } else {
                print("---------------\(url)")
            }
        }
    }
    
}
