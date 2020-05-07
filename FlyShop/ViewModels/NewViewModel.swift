//
//  NewViewModel.swift
//  FlyShop
//
//  Created by Karen Mirakyan on 5/7/20.
//  Copyright © 2020 Karen Mirakyan. All rights reserved.
//

import Foundation
class NewViewModel: ObservableObject {
    @Published var newItemList = [ProductViewModel]()
    
    init() {
        getNewItems()
    }
    
    func getNewItems() {
        NewService().getNew { (result) in
            NewService().getNew { (result) in
                if let result = result {
                    self.newItemList = result.filter{self.convertToDate(startDate: $0.date) <= 30}.map( ProductViewModel.init )
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


struct ProductViewModel: Identifiable {
    let id = UUID()
    
    var productModel: ProductModel
    
    init( model: ProductModel ) {
        self.productModel = model
    }
    
    var image: String {
        self.productModel.image
    }
    
    var price: String {
        self.productModel.productPrice + "$"
    }
    
    var name: String {
        self.productModel.productName
    }
    
    var size: String {
        self.productModel.productSize
    }
}
