//
//  SizeModel.swift
//  FlyShop
//
//  Created by Karen Mirakyan on 5/6/20.
//  Copyright © 2020 Karen Mirakyan. All rights reserved.
//

import Foundation

struct SizeModel {
    func sizeChart(gender: String, category: String, type: String ) -> [String]{
        
        if category == "Shoes" {
            if gender == "Male" {
                return ["36", "37", "38", "39", "40", "41", "42", "43", "44", "45", "46"]
            } else {
                return ["35", "36", "37", "38", "39", "40", "41"]
            }
        } else {
            if type == "Top" || type == "Underwear" {
                return ["XS", "S", "M", "L", "XL", "XXL", "XXXL"]
            } else {
                if gender == "Male" {
                    return ["28", "29", "30", "31", "32", "33", "34", "35", "36", "37", "38", "39", "40", "41", "42", "43", "44"]
                } else {
                    return ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16"]
                }
            }
        }
    }
}
