//
//  CartModel.swift
//  FlyShop
//
//  Created by Karen Mirakyan on 5/13/20.
//  Copyright © 2020 Karen Mirakyan. All rights reserved.
//

import Foundation
struct CartModel: Identifiable {
    var id = UUID()
    var product: ProductViewModel
    var size: String
}
