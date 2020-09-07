//
//  CartService.swift
//  FlyShop
//
//  Created by Karen Mirakyan on 5/15/20.
//  Copyright © 2020 Karen Mirakyan. All rights reserved.
//

import Foundation
import Firebase
import Alamofire

class CartService {
    let db = Firestore.firestore()
    
    func postOrderToFirestore(address: String, cardHolder: String, paymentDetails: OrderDetails, cartModelArray: [CartModel], completion: @escaping (Bool) -> ()) {
        
        var order = [[String: Any]]()
        
        for model in cartModelArray {
            
            order.append( ["size" : model.size,
                           "category" : model.product.category,
                           "image" : model.product.images,
                           "productId" : model.product.productId,
                           "productName" : model.product.name,
                           "productPrice" : Int( model.product.price )!,
                           "sale" : model.product.sale,
                           "gender" : model.product.gender,
                           "type": model.product.type,
                           "brand": model.product.brand,
                           "shipped": false,
                           "color": model.product.color] )
        }
        
        let details = [
            "PaymentID" : paymentDetails.PaymentID,
            "Amount" : paymentDetails.Amount,
            "Address": address,
            "CardHolder": cardHolder
        ] as [String : Any]
        
        
        self.db.collection("Orders").document(Auth.auth().currentUser!.phoneNumber!).setData(["products" : order,
                                                                                              "paymentDetails": details]) { (error) in
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
    
    func getShippingProducts(completion: @escaping (ShippingModel?) -> ()) {
        db.collection("Orders").document(Auth.auth().currentUser?.phoneNumber ?? "Admin").getDocument { (snapshot, error) in
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
