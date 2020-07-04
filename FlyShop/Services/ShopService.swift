//
//  ShopService.swift
//  FlyShop
//
//  Created by Karen Mirakyan on 7/3/20.
//  Copyright © 2020 Karen Mirakyan. All rights reserved.
//

import Foundation
import Firebase
class ShopService {
    let db = Firestore.firestore()
    
    func fetchShopProducts(shop: String, completion: @escaping ( ShopProductsModel? ) -> () ) {
        db.collection("AllShops").document(shop).collection("products").addSnapshotListener { (snapshot, error) in
            if error != nil {
                DispatchQueue.main.async {
                    completion( nil )
                }
                return
            }
            
            if snapshot?.isEmpty != true {
                
                var products = [ProductModel]()
                
                for documnt in snapshot!.documents {
                    if let model = try? documnt.data(as: ProductModel.self) {
                        products.append(model)
                    }
                }
                
                let shopProducts = ShopProductsModel(products: products)
                
                DispatchQueue.main.async {
                    completion( shopProducts )
                }
            }
        }
    }
}
