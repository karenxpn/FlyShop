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
        
        var order = [[String: Any]]()
        
        for model in cartModelArray {
            
            order.append( ["size" : model.size,
                         "category" : model.product.category,
                         "date" : model.product.date,
                         "description" : model.product.description,
                         "image" : model.product.image,
                         "productId" : model.product.productId,
                         "productName" : model.product.name,
                         "productPrice" : Int( model.product.priceWithSale )!,
                         "sale" : model.product.sale,
                         "gender" : model.product.gender,
                         "type": model.product.type,
                         "id": model.product.productId,
                         "shipped": false] )
        }
        
        db.collection("Orders").document(Auth.auth().currentUser!.phoneNumber!).getDocument { (snapshot, error) in
            if error != nil {
                DispatchQueue.main.async {
                    completion( false )
                }
                return
            }
            
            if let snapshot = snapshot, snapshot.exists {
                let products = try? snapshot.data(as: ShippingModel.self)
                for product in products!.products {
                        order.append([
                            "size" : product.size,
                            "category" : product.category,
                            "date" : product.date,
                            "description" : product.description,
                            "image" : product.image,
                            "productId" : product.productId,
                            "productName" : product.productName,
                            "productPrice" : product.productPrice,
                            "sale" : product.sale,
                            "gender" : product.gender,
                            "type": product.type,
                            "id": product.productId,
                            "shipped": product.shipped
                        ])
                    }
            }
            
            self.db.collection("Orders").document(Auth.auth().currentUser!.phoneNumber!).setData(["products" : order]) { (error) in
                if error != nil {
                    DispatchQueue.main.async {
                        completion( false )
                    }
                    return
                }
                
                DispatchQueue.main.async {
                    completion( true )
                }
            }
        }
    }
    
    func getShippingProducts(completion: @escaping (ShippingModel?) -> ()) {
        db.collection("Orders").document(Auth.auth().currentUser!.phoneNumber!).getDocument { (snapshot, error) in
            if error != nil {
                DispatchQueue.main.async {
                    completion( nil )
                }
                return
            }
            
            if let snapshot = snapshot, snapshot.exists {
                let products = try? snapshot.data(as: ShippingModel.self)
                DispatchQueue.main.async {
                    completion( products )
                }
            }
        }
        
    }
}
