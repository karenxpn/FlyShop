//
//  AllShopsFilter.swift
//  FlyShop
//
//  Created by Karen Mirakyan on 5/12/20.
//  Copyright © 2020 Karen Mirakyan. All rights reserved.
//

import Foundation

class AllShopsFilter: ObservableObject {
    
    @Published var category: String = ""
    @Published var price: Double = 400000
    
    
    func filter( model: ShopListViewModel) -> [ProductViewModel] {
        var filteredList = [ProductViewModel]()
        
        if category != "" {
            filteredList = model.products.filter{ $0.category == self.category }
        } else {
            filteredList = model.products
        }
        
        return filteredList.filter{Int( $0.priceWithSale )! <= Int( self.price )}
    }
}
