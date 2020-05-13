//
//  TrendModel.swift
//  FlyShop
//
//  Created by Karen Mirakyan on 5/12/20.
//  Copyright © 2020 Karen Mirakyan. All rights reserved.
//

import Foundation

struct TrendModel: Identifiable {
    var id = UUID()
    var image: String
    var category: String
    var productId: String
}
