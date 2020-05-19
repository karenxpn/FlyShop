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
    
    func fetchFilteredData(new: Bool, sale: Bool, brand: String, category: String, gender: String, size: [String], type: String, price: Double, completion: @escaping ( [ProductModel]?) -> () ) {
        
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
 
                    if let shop = try? document.data(as: ShopModel.self) {
                        shops.append(shop)
                    }

                }
                
                DispatchQueue.main.async {
                    
                    var filteredShops = [ShopModel]()
                    
                    if brand != "" {
                        for shop in shops {
                            if shop.shopName == brand {
                                filteredShops.append(shop)
                            }
                        }
                    } else {
                        filteredShops = shops
                    }
                    
                    var filteredCategory = [ProductModel]()
                    
                    for shop in filteredShops {
                        filteredCategory.append(contentsOf: shop.products )
                    }
                    
                    filteredCategory = filteredCategory.filter{ $0.category == category }
                    let filteredGender = filteredCategory.filter{ $0.gender == gender }
                    
                    
                    var filteredSale = [ProductModel]()
                    if sale {
                        filteredSale = filteredGender.filter{ $0.sale != 0 }
                    } else {
                        filteredSale = filteredGender
                    }
                    
                    
                    var filteredNew = [ProductModel]()
                    if new {
                        filteredNew = filteredSale.filter{ self.convertToDate(startDate: $0.date) <= 30 }
                    } else {
                        filteredNew = filteredSale
                    }
                    
                    var filteredSize = [ProductModel]()
                    if size.isEmpty == false {
                        
                        for currentSize in size {
                            filteredSize = filteredNew.filter{ $0.productSize.contains(currentSize)}
                        }
                    } else {
                        filteredSize = filteredNew
                    }
                                        
                    var filterPrice = [ProductModel]()
                    for index in 0..<filteredSize.count {
                        let priceWithSale = filteredSize[index].productPrice - filteredSize[index].productPrice*filteredSize[index].sale/100
                        if priceWithSale <= Int( price ) {
                            filterPrice.append(filteredSize[index])
                        }
                        
                    }
                    //let filterPrice = filteredSize.filter{ $0.productPrice <= Int( price )}
                    
                    var filteredType = [ProductModel]()
                    if type != "" {
                        filteredType = filterPrice.filter { $0.type.contains(type) }
                    } else {
                        filteredType = filterPrice
                    }
                    
                    completion( filteredType )
                }
                
            }
        }
        
    }
    
    func convertToDate( startDate: String ) -> Int {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "hy")
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let formatedStartDate = dateFormatter.date(from: startDate)
        let currentDate = Date()
        let components = Set<Calendar.Component>([.day])
        let differenceOfDate = Calendar.current.dateComponents(components, from: formatedStartDate!, to: currentDate)
        
        return differenceOfDate.day!
        
    }
    
}

