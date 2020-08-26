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
    
    func fetchFilteredData(new: Bool, sale: Bool, brand: String, category: String, gender: String, size: [String], type: String, price: Double, completion: @escaping ( [ProductViewModel]?) -> () ) {
        
        db.collection("AllShops").getDocuments { (snapshot, error) in
            if error != nil {
                DispatchQueue.main.async {
                    completion( nil )
                }
                return
            }
            
            if snapshot?.isEmpty == false {
                var products = [ProductModel]()
                
                for doc in snapshot!.documents {
                    doc.reference.collection("products").addSnapshotListener { (snap, errorMessage) in
                        if errorMessage != nil {
                            DispatchQueue.main.async {
                                completion( nil )
                            }
                            return
                        }
                        
                        if snap?.isEmpty == false {
                            for document in snap!.documents {
                                if let model = try? document.data(as: ProductModel.self) {
                                    products.append(model)
                                }
                            }
                            
                            
                            DispatchQueue.main.async {
                                
                                var filterProducts = products.map( ProductViewModel.init )
                                
                                
                                filterProducts = filterProducts.filter{ $0.category == category }
                                filterProducts = filterProducts.filter{ $0.gender == gender }
                                if sale { filterProducts = filterProducts.filter{ $0.sale > 0 } }
                                if new { filterProducts = filterProducts.filter { self.convertToDate(startDate: $0.date) <= 30 }}
                                if size.isEmpty == false {
                                    
                                    for filterSize in size {
                                        filterProducts = filterProducts.filter{ $0.size.contains( filterSize ) }
                                    }
                                }
                                filterProducts = filterProducts.filter { Int( $0.price )! <= Int( price ) }
                                if type != "" { filterProducts = filterProducts.filter{ $0.type == type }}
                                if brand != "" { filterProducts = filterProducts.filter{ $0.brand == brand }}
                                
                                completion( filterProducts )
                            }
                        }
                        
                    }
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

