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
                    if let shopName = document.get("shopName") as? String {
                        if let image = document.get("image") as? String {
                            
                            var productArray = [ProductModel]()
                            
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
                            
                            let model = ShopModel(shopName: shopName, image: image, products: productArray)
                            shops.append(model)
                        }
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
                    
                    print(filteredSize)
                    
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

