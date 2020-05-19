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
        db.collection("AllShops").getDocuments { (snapshot, error) in
            if error != nil {
                DispatchQueue.main.async {
                    completion( nil )
                }
                return
            }
            
            
            if snapshot?.isEmpty == false {
                
                var productArray = [ProductModel]()
                
                for document in snapshot!.documents {
                    
                    if let model = try? document.data(as: ShopModel.self) {
                        productArray.append(contentsOf: model.products)
                    }
                    
                }
                
                DispatchQueue.main.async {
                    completion( productArray.filter{ $0.sale != 0 } )
                }
            }
        }
    }
}
