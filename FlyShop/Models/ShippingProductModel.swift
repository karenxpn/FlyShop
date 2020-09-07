//
//  ReviewModel.swift
//  FlyShop
//
//  Created by Karen Mirakyan on 5/15/20.
//  Copyright © 2020 Karen Mirakyan. All rights reserved.
//

import Foundation

struct ShippingProductModel: Codable {
    var category: String
    var image: [String]
    var productPrice: Int
    var productName: String
    var description: String
    var date: String
    var sale: Int
    var gender: String
    var type: String
    var productId: String
    var size: String
    var shipped: Bool
    var color: String
}
