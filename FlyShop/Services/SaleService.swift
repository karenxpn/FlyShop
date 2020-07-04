//
//  SaleService.swift
//  FlyShop
//
//  Created by Karen Mirakyan on 5/8/20.
//  Copyright © 2020 Karen Mirakyan. All rights reserved.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

class SaleService {
    
    let db = Firestore.firestore()
    
    func fetchData(completion: @escaping ( [ProductModel]? ) -> () ) {
        
        self.db.collection("AllShops").getDocuments { (snapshot, error) in
            if error != nil {
                DispatchQueue.main.async {
                    completion( nil )
                }
                return
            }
            
            if snapshot?.isEmpty != true {
                
                var productArray = [ProductModel]()
                
                for doc in snapshot!.documents {
                    doc.reference.collection("products").whereField("sale", isGreaterThan: 0).addSnapshotListener { (snap, errorMessage) in
                        if errorMessage != nil {
                            DispatchQueue.main.async {
                                completion( nil )
                            }
                            return
                        }
                        
                        if snap?.isEmpty != true {
                            for document in snap!.documents {
                                if let model = try? document.data(as: ProductModel.self) {
                                    productArray.append(model)
                                }
                            }
                            
                            DispatchQueue.main.async {
                                completion( productArray )
                            }
                        }
                    }
                }
            }
            
        }
    }
}
