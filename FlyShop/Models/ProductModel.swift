//
//  ProductModel.swift
//  FlyShop
//
//  Created by Karen Mirakyan on 5/7/20.
//  Copyright © 2020 Karen Mirakyan. All rights reserved.
//

import Foundation

struct ProductModel: Codable {    
    var productName: String
    var productId: String
    var images: [String]
    var productPrice: Int
    var sale: Int
    var gender: String
    var category: String
    var type: String
    var productSize: [String]
    var description: String
    var color: String
    var date: String
    var ar: Bool
    var brand: String
}
