//
//  AllShopsViewModel.swift
//  FlyShop
//
//  Created by Karen Mirakyan on 5/6/20.
//  Copyright © 2020 Karen Mirakyan. All rights reserved.
//

import Foundation
import SwiftUI

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
                self.allShops = result.map(ShopListViewModel.init)
                self.showLoading = false
            }
        }
    }
}
