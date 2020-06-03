//
//  FilterTypeModel.swift
//  FlyShop
//
//  Created by Karen Mirakyan on 5/11/20.
//  Copyright © 2020 Karen Mirakyan. All rights reserved.
//

import Foundation

struct FilterTypeModel {
    
    let filterCategories = ["Հագուստ", "Կոշիկ", "Աքսեսուարներ"]
    
    let typeMap = [
        "Հագուստ" : ["Top", "Bottom", "Ներքնազգեստ"],
        "Կոշիկ" : ["Աշուն-Ձմեռ", "Գարուն-Ամառ"],
        "Աքսեսուարներ" : ["Ժամացույցներ","Արևային ակնոց","Պայուսակներ","Գլխարկներ","Գոտիներ","Զարդեր"]
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
