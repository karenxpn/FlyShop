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
        "Հագուստ" : ["Կոստյումներ", "Շապիկներ", "Շապիկներ : Պոլոներ", "Տաբատներ", "Շորտեր", "Ջինս", "Հուդիներ և Սվիտրներ", "Բաճկոններ", "Լողազգեստեր", "Սպորտային Հագուստ"],
        "Կոշիկ" : ["Ամառային դասական", "Սանդալ", "Ամառային սպորտային", "Դասական կոշիկ​", "Չարոխ", "Սպորտային", "Կիսաճտքավոր դասական", "Կիսաճտքավոր սպորտային", "Ուգգի"],
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
