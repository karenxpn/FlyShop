//
//  FilterService.swift
//  FlyShop
//
//  Created by Karen Mirakyan on 5/11/20.
//  Copyright © 2020 Karen Mirakyan. All rights reserved.
//

import Foundation
import Firebase

class FilterService {
    let db = Firestore.firestore()
    
    func fetchFilteredData( category: String, gender: String, size: [String], type: String, completion: @escaping ( [ProductModel]?) -> () ) {
        
        db.collection("AllShops").addSnapshotListener { (snapshot, error) in
            if error != nil {
                DispatchQueue.main.async {
                    completion( nil )
                }
                return
            }
            
            if snapshot?.isEmpty == false {
                                
                var productArray = [ProductModel]()
                
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
                                                                    
                                                                    let model = ProductModel(category: category, image: imageArray, productPrice: price, productName: name, productSize: sizeArray, description: description, date: date, sale: sale, gender: gender, type: type)
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
                        }
                    }
                }
                
                DispatchQueue.main.async {
                    let filteredCategory = productArray.filter{ $0.category.contains(category) }
                    let filterdGender = filteredCategory.filter{ $0.gender.contains(gender) }
                    
                    var filteredSize = [ProductModel]()
                    if size.isEmpty == false {

                        for currentSize in size {
                            filteredSize = filterdGender.filter{ $0.productSize.contains(currentSize)}
                        }
                    } else {
                        filteredSize = filterdGender
                    }
                    
                    var filteredType = [ProductModel]()
                    if type != "" {
                        filteredType = filteredSize.filter { $0.type.contains(type) }
                    } else {
                        filteredType = filteredSize
                    }
                    completion( filteredType )
                }
            }
        }
        
    }
}
