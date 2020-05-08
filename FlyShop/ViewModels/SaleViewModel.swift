//
//  SaleViewModel.swift
//  FlyShop
//
//  Created by Karen Mirakyan on 5/8/20.
//  Copyright © 2020 Karen Mirakyan. All rights reserved.
//

import Foundation

class SaleViewModel: ObservableObject {
    @Published var productsUnderSale = [SaleProductViewModel]()
    
    init() {
        getProducts()
    }
    
    func getProducts() {
        SaleService().fetchData { (result) in
            if let result = result {
                self.productsUnderSale = result.map(SaleProductViewModel.init)
            }
        }
    }
}


struct SaleProductViewModel: Identifiable {
    var id = UUID()
    var productModel: ProductModel
    
    init( model: ProductModel ) {
        self.productModel = model
    }
    
    var image: String {
        self.productModel.image
    }
    
    var price: String {
        String(self.productModel.productPrice - self.productModel.productPrice * self.productModel.sale/100 )
    }
    
    var name: String {
        self.productModel.productName
    }
    
    var size: String {
        self.productModel.productSize
    }
    
}
