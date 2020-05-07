//
//  ProductModel.swift
//  FlyShop
//
//  Created by Karen Mirakyan on 5/7/20.
//  Copyright © 2020 Karen Mirakyan. All rights reserved.
//

import Foundation

struct ProductModel: Identifiable {
    var id = UUID()
    
    var category: String
    var image: String
    var productPrice: String
    var productName: String
    var productSize: String
    var date: String
}
