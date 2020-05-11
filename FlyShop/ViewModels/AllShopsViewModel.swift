//
//  AllShopsViewModel.swift
//  FlyShop
//
//  Created by Karen Mirakyan on 5/6/20.
//  Copyright © 2020 Karen Mirakyan. All rights reserved.
//

import Foundation

class AllShopsViewModel: ObservableObject {
    
    @Published var allShops = [ShopListViewModel]()
    @Published var showLoading: Bool = false
    
    init() {
        getShopList()
    }
    
    func getShopList() {
        self.showLoading = true
        AllShopService().getAllShops { result in
            if let result = result {
                self.showLoading = false
                self.allShops = result.map(ShopListViewModel.init)
            }
        }
    }
}


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
