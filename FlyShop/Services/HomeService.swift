//
//  HomeService.swift
//  FlyShop
//
//  Created by Karen Mirakyan on 5/12/20.
//  Copyright © 2020 Karen Mirakyan. All rights reserved.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

class HomeService {
    
    let db = Firestore.firestore()
    
    func fetchTrends(category: String, complterion: @escaping ([TrendModel]?) -> ()) {
        
        db.collection("Trends").addSnapshotListener { (snapshot, error) in
            if error != nil {
                DispatchQueue.main.async {
                    complterion( nil )
                }
                return
            }
            
            if snapshot?.isEmpty == false {
                var trends = [TrendModel]()
                
                for document in snapshot!.documents {
                    if let image = document.get("image") as? String {
                        if let category = document.get("category") as? String {
                            if let productId = document.get( "productId") as? String {
                                let model = TrendModel(image: image, category: category, productId: productId)
                                trends.append(model)
                            }
                        }
                    }
                }
                
                DispatchQueue.main.async {
                    complterion( trends.filter{ $0.category == category} )
                }
            }
        }
    }
    
    func fetchWithProductId( id: String, completion: @escaping ( ProductModel? ) -> ()) {
        db.collection("AllShops").getDocuments { (snapshot, error) in
            if error != nil {
                DispatchQueue.main.async {
                    completion( nil )
                }
                return
            }
            
            if snapshot?.isEmpty == false {
                                
                var shopArray = [ShopModel]()
                var foundProduct: ProductModel? = nil
                
                for document in snapshot!.documents {
                    
                    if let shop = try? document.data(as: ShopModel.self) {
                        shopArray.append(shop)
                    }
                }
                
                DispatchQueue.main.async {
//                    for shop in shopArray {
//                        for product in shop.products {
//                            if product.productId == id {
//                                foundProduct = product
//                            }
//                        }
//                    }
                    completion( foundProduct )
                }
            }
        }
    }
}
