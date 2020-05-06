//
//  SizeModel.swift
//  FlyShop
//
//  Created by Karen Mirakyan on 5/6/20.
//  Copyright © 2020 Karen Mirakyan. All rights reserved.
//

import Foundation

struct SizeModel {
    func sizeChart(gender: String, category: String) -> [String]{
        
        if category == "Shoes" {
            if gender == "Men" {
                return ["36", "37", "38", "39", "40", "41", "42", "43", "44", "45", "46"]
            } else {
                return ["35", "36", "37", "38", "39", "40", "41"]
            }
        } else {
            return ["XS", "S", "M", "L", "XL", "XXL", "XXXL"]
        }
    }
}
