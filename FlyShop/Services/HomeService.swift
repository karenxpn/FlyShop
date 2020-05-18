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
                                
                var foundProduct: ProductModel? = nil
                
                for document in snapshot!.documents {
                    if let products = document.get( "products" ) as? [[String: Any]] {
                        for product in products {
                            if let price = product["productPrice"] as? Int {
                                if let name = product["productName"] as? String {
                                    if let description = product["description"] as? String {
                                        if let date = product["date"] as? String {
                                            if let category = product["category"] as? String {
                                                if let sale = product["sale"] as? Int {
                                                    if let gender = product["gender"] as? String {
                                                        if let type = product["type"] as? String {
                                                            if let productId = product["productId"] as? String {
                                                                
                                                                
                                                                if let size = product["productSize"] as? [String] {
                                                                    var sizeArray = [String]()
                                                                    for productSize in size {
                                                                        sizeArray.append(productSize)
                                                                    }
                                                                    
                                                                    if let images = product["image"] as? [String] {
                                                                        var imageArray = [String]()
                                                                        for image in images {
                                                                            imageArray.append(image)
                                                                        }
                                                                        
                                                                        let model = ProductModel(category: category, image: imageArray, productPrice: price, productName: name, productSize: sizeArray, description: description, date: date, sale: sale, gender: gender, type: type, productId: productId)
                                                                        
                                                                        if model.productId == id {
                                                                            foundProduct = (model)
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
                    completion( foundProduct )
                }
                
            }
        }
    }
}
