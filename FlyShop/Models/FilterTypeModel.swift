//
//  FilterTypeModel.swift
//  FlyShop
//
//  Created by Karen Mirakyan on 5/11/20.
//  Copyright © 2020 Karen Mirakyan. All rights reserved.
//

import Foundation

struct FilterTypeModel {
    
    let filterCategories = ["Clothes", "Shoes", "Accessories"]
    
    let typeMap = [
        "Clothes" : ["Top", "Bottom", "Underwear"],
        "Shoes" : ["Autumn-Winter", "Spring-Summer"],
        "Accessories" : ["Watches","Sunglasses","Bags","Hats","Belts","Jewelery"]
    ]
}

extension FilterTypeModel {
    func categories() -> [String] {
        return filterCategories
    }
    
    func categoryType( category: String ) -> [String] {
        if category == "" {
            return [String]()
        }
        return typeMap[category]!
    }
    

}
