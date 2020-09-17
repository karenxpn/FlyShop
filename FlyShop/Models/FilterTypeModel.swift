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
    
    var typeMap = [
        "Հագուստ" : ["Կոստյումներ", "Շապիկներ", "Շապիկներ : Պոլոներ", "Տաբատներ", "Շորտեր", "Ջինս", "Հուդիներ և Սվիտերներ", "Բաճկոններ", "Լողազգեստներ", "Սպորտային Հագուստ", "Գուլպա"],
        "Կոշիկ" : ["Ամառային դասական", "Սանդալ", "Ամառային սպորտային", "Դասական կոշիկ​", "Չարոխ", "Սպորտային", "Կիսաճտքավոր դասական", "Կիսաճտքավոր սպորտային", "Ուգգի"],
        "Աքսեսուարներ" : ["Ժամացույցներ","Արևային ակնոցներ","Պայուսակներ","Գլխարկներ","Գոտիներ","Զարդեր"]
    ]
}

extension FilterTypeModel {
    func categories() -> [String] {
        return filterCategories
    }
    
    func categoryType( category: String, gender: String ) -> [String] {
        
        var typeArray = typeMap[category]!
        
        if category == "" {
            return [String]()
        }
        
        if gender == "Իգական" {
            if category == "Հագուստ" {
                typeArray.append("Զգեստ")
            } else if category == "Կոշիկ" {
                typeArray.append("Բարձրակրունկ")
            }
        }
        return typeArray
    }
    

}
