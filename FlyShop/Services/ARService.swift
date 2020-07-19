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
    
    func fetchARProduct(productName: String, completion: @escaping( String? ) -> ()) {

        let storage = Storage.storage().reference().child("AR Products/toy_biplane.usdz")
        
        let documentDirURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        let fileURL = documentDirURL.appendingPathComponent("ARProducts").appendingPathExtension("usdz")
        print("File path: \(fileURL.path)")
        
                
            
        storage.write(toFile: fileURL) { (url, error) in
            if error != nil {
                DispatchQueue.main.async {
                    completion( nil )
                }
                return
            }
            
            DispatchQueue.main.async {
                completion( url?.path )
            }
        }
    }
    
    func getARProductWithPath(path: String, completion: @escaping( Model? ) -> () ) {
        
        let fileManager = FileManager.default
        let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        do {
            let fileURLs = try fileManager.contentsOfDirectory(at: documentsURL, includingPropertiesForKeys: nil)
                .filter{ $0.pathExtension == "usdz" }
            
            print(fileURLs)
            print(fileURLs.count)
            
            let model = Model(modelName: fileURLs.first!.absoluteString)

            DispatchQueue.main.async {
                completion(model)
            }
            
        } catch {
            print("Error while enumerating files \(documentsURL.path): \(error.localizedDescription)")
        }
    }
    
}
