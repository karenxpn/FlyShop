//
//  SaleViewModel.swift
//  FlyShop
//
//  Created by Karen Mirakyan on 5/8/20.
//  Copyright © 2020 Karen Mirakyan. All rights reserved.
//

import Foundation

class SaleViewModel: ObservableObject {
    @Published var productsUnderSale = [ProductViewModel]()
    @Published var showLoading: Bool = false
    
    init() {
        getProducts()
    }
    
    func getProducts() {
        self.showLoading = true
        SaleService().fetchData { (result) in
            if let result = result {
                self.productsUnderSale = result.map(ProductViewModel.init)
                self.showLoading = false
            }
        }
    }
}
