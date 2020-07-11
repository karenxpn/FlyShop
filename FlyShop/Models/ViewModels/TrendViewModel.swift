//
//  TrendViewModel.swift
//  FlyShop
//
//  Created by Karen Mirakyan on 6/3/20.
//  Copyright © 2020 Karen Mirakyan. All rights reserved.
//

import Foundation

struct TrendViewModel: Identifiable {
    
    var id = UUID()
    var trendModel: TrendModel
    
    init(model: TrendModel) {
        self.trendModel = model
    }
    
    var image: String {
        self.trendModel.image
    }
    
    var productId: String {
        self.trendModel.productId
    }
    
    var shop: String {
        self.trendModel.shopId
    }
}
