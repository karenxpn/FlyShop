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
    
    var images: [String] {
        self.productModel.images
    }
    
    var price: String {
        String(self.productModel.productPrice - self.productModel.productPrice * self.productModel.sale/100 )
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
    
    var category: String {
        self.productModel.category
    }
    
    var productId: String {
        self.productModel.productId
    }
    
    var date: String {
        self.productModel.date
    }
    
    var type: String {
        self.productModel.type
    }
    
    var gender: String {
        self.productModel.gender
    }
    
    var ar: Bool {
        self.productModel.ar
    }
    
    var color: String {
        self.productModel.color
    }
    
    var brand: String {
        self.productModel.brand
    }
}
