//
//  ShopModel.swift
//  FlyShop
//
//  Created by Karen Mirakyan on 5/6/20.
//  Copyright © 2020 Karen Mirakyan. All rights reserved.
//

import Foundation
struct ShopModel: Identifiable {
    
    var id = UUID()
    var shopName: String
    var image: String
    var products: [ProductModel]
    
}
