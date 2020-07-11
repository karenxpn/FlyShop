//
//  HomeViewModel.swift
//  FlyShop
//
//  Created by Karen Mirakyan on 5/12/20.
//  Copyright © 2020 Karen Mirakyan. All rights reserved.
//

import Foundation

class HomeViewModel: ObservableObject {
    @Published var category: String = "Հագուստ"
    @Published var trendList = [TrendViewModel]()
    @Published var productId = ""
    @Published var shop = ""
    @Published var foundProduct: ProductViewModel? = nil
    
    init() {
        getTrends()
    }
    
    func getTrends() {
        HomeService().fetchTrends(category: self.category) { (result) in
            if let result = result {
                self.trendList = result.map(TrendViewModel.init)
            }
        }
    }
    
    func getProductById() {
        HomeService().fetchWithProductId(id: productId, shop: self.shop) { (result) in
            if let result = result {
                self.foundProduct = ProductViewModel(model: result)
            }
        }
    }
    
}
