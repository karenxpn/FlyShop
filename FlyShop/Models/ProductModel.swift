//
//  ProductModel.swift
//  FlyShop
//
//  Created by Karen Mirakyan on 5/7/20.
//  Copyright © 2020 Karen Mirakyan. All rights reserved.
//

import Foundation

struct ProductModel: Codable {    
    var category: String
    var imagesByColor: [ProductColorImage]
    var productPrice: Int
    var productName: String
    var productSize: [String]
    var description: String
    var date: String
    var sale: Int
    var gender: String
    var type: String
    var productId: String
    var ar: Bool
}
