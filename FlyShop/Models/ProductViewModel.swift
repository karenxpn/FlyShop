//
//  ProductViewModel.swift
//  FlyShop
//
//  Created by Karen Mirakyan on 5/10/20.
//  Copyright © 2020 Karen Mirakyan. All rights reserved.
//

import Foundation

struct ProductViewModel: Identifiable {
    let id = UUID()
    
    var productModel: ProductModel
    
    init( model: ProductModel ) {
        self.productModel = model
    }
    
    var image: [String] {
        self.productModel.image
    }
    
    var price: String {
        String(self.productModel.productPrice)
    }
    
    var name: String {
        self.productModel.productName
    }
    
    var size: [String] {
        self.productModel.productSize
    }
    
    var description: String {
        self.productModel.description
    }
    
    var sale: Int {
        self.productModel.sale
    }
    
    var priceWithSale: String {
        String(self.productModel.productPrice - self.productModel.productPrice * self.productModel.sale/100 )
    }
}
