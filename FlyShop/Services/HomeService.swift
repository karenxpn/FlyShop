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
                    
                    if let model = try? document.data(as: TrendModel.self ) {
                        trends.append( model )
                    }

                }
                
                DispatchQueue.main.async {
                    complterion( trends.filter{ $0.category == category} )
                }
            }
        }
    }
    
    func fetchWithProductId( id: String, shop: String, completion: @escaping ( ProductModel? ) -> ()) {
        db.collection("AllShops").document(shop).collection("products").whereField("productId", isEqualTo: id).getDocuments { (snapshot, error) in
            if error != nil {
                DispatchQueue.main.async {
                    completion( nil )
                }
                return
            }
            
            
            if snapshot?.isEmpty == false {
                var foundProduct: ProductModel? = nil
                
                for document in snapshot!.documents {
                    if let model = try? document.data(as: ProductModel.self) {
                        foundProduct = model
                        break
                    }
                }
                
                DispatchQueue.main.async {
                    completion( foundProduct )
                }
            }
        }
    }
}
