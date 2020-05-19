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
                    if let model = try? document.data(as: ShopModel.self) {
                        shops.append(model)
                    }
                }
                
                DispatchQueue.main.async {
                    completion( shops )
                }
            }
        }
    }
    
}



