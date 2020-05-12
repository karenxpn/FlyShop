//
//  HomeService.swift
//  FlyShop
//
//  Created by Karen Mirakyan on 5/12/20.
//  Copyright © 2020 Karen Mirakyan. All rights reserved.
//

import Foundation
import Firebase

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
                            let model = TrendModel(image: image, category: category)
                            trends.append(model)
                        }
                    }
                }
                
                DispatchQueue.main.async {
                    complterion( trends.filter{ $0.category == category} )
                }
            }
        }
    }
}
