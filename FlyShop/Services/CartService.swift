//
//  CartService.swift
//  FlyShop
//
//  Created by Karen Mirakyan on 5/15/20.
//  Copyright © 2020 Karen Mirakyan. All rights reserved.
//

import Foundation
import Firebase
import MessageUI
class CartService {
    let db = Firestore.firestore()
    
    func postOrderToFirestore(cartModelArray: [CartModel], completion: @escaping (Bool) -> ()) {
        
        for model in cartModelArray {
            
            let order = ["size" : model.size,
                         "category" : model.product.category,
                         "date" : model.product.date,
                         "description" : model.product.description,
                         "image" : model.product.image,
                         "productId" : model.product.productId,
                         "productName" : model.product.name,
                         "productPrice" : Int( model.product.priceWithSale )!,
                         "productSize" : model.product.size,
                         "sale" : model.product.sale,
                         "gender" : model.product.gender,
                         "type": model.product.type,
                         "inReview": true,
                         "available": false] as [String : Any]
            
            self.db.collection("Carts").document(Auth.auth().currentUser!.phoneNumber!).collection("products").addDocument(data: order)
        }
        
        DispatchQueue.main.async {
            completion( true )
        }
    }
    
    func getProductsInReview(completion: @escaping ([ReviewModel]?) -> ()) {
        
        db.collection("Carts").document(Auth.auth().currentUser!.phoneNumber!).collection("products").addSnapshotListener { (snapshot, error) in
            if error != nil {
                DispatchQueue.main.async {
                    completion( nil )
                }
                return
            }
            
            if snapshot?.isEmpty == false {
                
                var reviewList = [ReviewModel]()

                for document in snapshot!.documents {
                    
                    if let model = try? document.data(as: ReviewModel.self) {
                        reviewList.append(model)
                    }

                }
                
                DispatchQueue.main.async {
                    completion( reviewList )
                }
            }
        }
    }
}
