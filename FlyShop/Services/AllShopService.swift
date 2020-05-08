//
//  AllShopService.swift
//  FlyShop
//
//  Created by Karen Mirakyan on 5/6/20.
//  Copyright © 2020 Karen Mirakyan. All rights reserved.
//

import Foundation
import Firebase

class AllShopService {
    
    let db = Firestore.firestore()
    
    func getAllShops(completion: @escaping ( [ShopModel]?) -> ()) {
        db.collection("AllShops").addSnapshotListener { (snapshot, error) in
            if error != nil {
                DispatchQueue.main.async {
                    completion( nil )
                }
                return
            }
            
            if snapshot?.isEmpty == false {
                var shops = [ShopModel]()
                
                for document in snapshot!.documents {
                    if let shopName = document.get("shopName") as? String {
                        if let image = document.get("image") as? String {
                            
                            var productArray = [ProductModel]()
                            
                            if let products = document.get( "products" ) as? [[String: Any]] {
                                for product in products {
                                    if let price = product["productPrice"] as? Int {
                                        if let name = product["productName"] as? String {
                                            if let size = product["productSize"] as? String {
                                                if let date = product["date"] as? String {
                                                    if let image = product["image"] as? String {
                                                        if let category = product["category"] as? String {
                                                            if let sale = product["sale"] as? Int {
                                                                let model = ProductModel(category: category, image: image, productPrice: price, productName: name, productSize: size, date: date, sale: sale)
                                                                
                                                                productArray.append(model)
                                                            }
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }

                            
                            
                            
                            let model = ShopModel(shopName: shopName, image: image, products: productArray)
                            shops.append(model)
                        }
                    }
                }
                
                DispatchQueue.main.async {
                    completion( shops )
                }
            }
        }
    }
    
}



