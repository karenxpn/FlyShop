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
    
    init() {
        getShopList()
    }
    
    func getShopList() {
        AllShopService().getAllShops { result in
            if let result = result {
                self.allShops = result.map(ShopListViewModel.init)
                print("The data is here")
                print(self.allShops)
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
}
