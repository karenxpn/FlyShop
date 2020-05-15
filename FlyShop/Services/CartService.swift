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

                    if let id = document.get("productId") as? String {
                        if let name = document.get( "productName") as? String {
                            if let price = document.get("productPrice") as? Int {
                                if let size = document.get("size") as? String {
                                    if let sizeArray = document.get("productSize") as? [String] {
                                        if let category = document.get( "category") as? String {
                                            if let date = document.get( "date" ) as? String {
                                                if let description = document.get( "description") as? String {
                                                    if let images = document.get( "image" ) as? [String] {
                                                        if let sale = document.get( "sale" ) as? Int {
                                                            if let type = document.get( "type") as? String {
                                                                if let gender = document.get( "gender" ) as? String {
                                                                    if let inReview = document.get("inReview") as? Bool {
                                                                        if let available = document.get("available") as? Bool {

                                                                            let model = ReviewModel(category: category, image: images, productPrice: price, productName: name, productSize: sizeArray, description: description, date: date, sale: sale, gender: gender, type: type, productId: id, size: size, inReview: inReview, available: available )

                                                                            reviewList.append(model)
                                                                        }
                                                                    }
                                                                }
                                                            }
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
                
                DispatchQueue.main.async {
                    completion( reviewList )
                }
            }
        }
    }
}
