//
//  SaleService.swift
//  FlyShop
//
//  Created by Karen Mirakyan on 5/8/20.
//  Copyright © 2020 Karen Mirakyan. All rights reserved.
//

import Foundation
import Firebase

class SaleService {
    
    let db = Firestore.firestore()
    
    func fetchData(completion: @escaping ( [ProductModel]? ) -> () ) {
        db.collection("AllShops").getDocuments { (snapshot, error) in
            if error != nil {
                DispatchQueue.main.async {
                    completion( nil )
                }
                return
            }
            
            
            if snapshot?.isEmpty == false {
                
                var productArray = [ProductModel]()
                
                for document in snapshot!.documents {
                    
                    let data = document.data()
                    
                    if let products = data[ "products"] as? [[String: Any]] {
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
                }
                
                DispatchQueue.main.async {
                    completion( productArray.filter{ $0.sale != 0 } )
                }
            }
        }
    }
}
