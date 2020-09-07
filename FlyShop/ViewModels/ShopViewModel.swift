//
//  ShopViewModel.swift
//  FlyShop
//
//  Created by Karen Mirakyan on 7/3/20.
//  Copyright © 2020 Karen Mirakyan. All rights reserved.
//

import Foundation
class ShopViewModel: ObservableObject {
    @Published var shopProducts = [ProductViewModel]()
    @Published var shopName: String = ""
    @Published var loading: Bool = false
    @Published var category: String = ""
    @Published var price: Double = 400000
    
    func getProducts() {
        self.loading = true
        self.shopProducts.removeAll(keepingCapacity: false)
        ShopService().fetchShopProducts(shop: shopName) { (shopProducts) in
            if let result = shopProducts {
                self.shopProducts = result.map( ProductViewModel.init )
                self.loading = false
            }
        }
    }
    

    func filter() -> [ProductViewModel] {
        if category != "" {
            return shopProducts.filter{ $0.category == self.category }
            .filter{Int( $0.price )! <= Int( self.price )}
        } else {
            return shopProducts.filter{Int( $0.price )! <= Int( self.price )}
        }
    }
}
