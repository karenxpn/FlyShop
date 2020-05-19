//
//  NewService.swift
//  FlyShop
//
//  Created by Karen Mirakyan on 5/7/20.
//  Copyright © 2020 Karen Mirakyan. All rights reserved.
//

import Foundation
import Firebase

class NewService {
    let db = Firestore.firestore()
    
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
    
    func getNew(completion: @escaping ( [ProductModel]?) -> ()) {
        
        
        self.db.collection("AllShops").getDocuments { (snapshot, error) in
            if error != nil {
                DispatchQueue.main.async {
                    completion( nil )
                }
                return
            }
            
            if snapshot?.isEmpty == false {
                
                var productArray = [ProductModel]()
                
                for document in snapshot!.documents {
                    
                    if let model = try? document.data(as: ShopModel.self) {
                        productArray.append(contentsOf: model.products)
                    }
                }
                
                DispatchQueue.main.async {
                    completion( productArray.filter{ self.convertToDate(startDate: $0.date) <= 30} )
                }
            }
        }
 
    }
}
