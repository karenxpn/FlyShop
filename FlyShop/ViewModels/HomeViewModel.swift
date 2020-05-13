//
//  HomeViewModel.swift
//  FlyShop
//
//  Created by Karen Mirakyan on 5/12/20.
//  Copyright © 2020 Karen Mirakyan. All rights reserved.
//

import Foundation

class HomeViewModel: ObservableObject {
    @Published var category: String = "Clothes"
    @Published var trendList = [TrendViewModel]()
    @Published var productId = ""
    @Published var foundProduct = [ProductViewModel]()
    
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
        HomeService().fetchWithProductId(id: productId) { (result) in
            if let result = result {
                self.foundProduct = result.map(ProductViewModel.init)
            }
        }
    }
    
}

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
}
