//
//  ShopListViewModel.swift
//  FlyShop
//
//  Created by Karen Mirakyan on 6/3/20.
//  Copyright © 2020 Karen Mirakyan. All rights reserved.
//

import Foundation

struct ShopListViewModel: Identifiable {
    var id = UUID()
    var shopModel: ShopModel
    
    init( model: ShopModel ) {
        self.shopModel = model
    }
    
    var name: String {
        self.shopModel.shopName
    }
    
    var image: String {
        self.shopModel.image
    }
    
    var products: [ProductViewModel] {
        self.shopModel.products.map(ProductViewModel.init)
    }
}
