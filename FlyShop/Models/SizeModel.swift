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
        
        if category == "Կոշիկ" {
            if gender == "Արական" {
                return ["36", "37", "38", "39", "40", "41", "42", "43", "44", "45", "46"]
            } else {
                return ["35", "36", "37", "38", "39", "40", "41"]
            }
        } else {
            
            if type == "Գուլպա" {
                if gender == "Արական" {
                    return ["39-46"]
                } else {
                    return ["36-43"]
                }
            } else if type == "Ջինս" || type == "Տաբատներ" || type == "Շորտեր" {
                if gender == "Արական" {
                    return ["28", "29", "30", "31", "32", "33", "34", "35", "36", "37", "38", "39", "40", "41", "42", "43", "44"]
                } else {
                    return ["31", "34", "36", "38", "40", "42", "44", "46", "48", "50", "52", "54"]
                }
            } else if type == "Ներքնազգեստ" {
                return [String]()
            } else {
                return ["XS", "S", "M", "L", "XL", "XXL", "XXXL"]

            }
        }
    }
}
