//
//  CartViewModel.swift
//  FlyShop
//
//  Created by Karen Mirakyan on 5/13/20.
//  Copyright © 2020 Karen Mirakyan. All rights reserved.
//

import Foundation

class CartViewModel: ObservableObject {
    @Published var cartProducts = [CartModel]()
    @Published var reviewProducts = [ReviewViewModel]()
    @Published var navTitle: String = "My Cart"
    
    init() {
        UserDefaults.standard.set(false, forKey: "InReview")
    }

    
    func postProductsToReview() {
        CartService().postOrderToFirestore(cartModelArray: cartProducts) { (result) in
            if result {
                UserDefaults.standard.set(true, forKey: "InReview")
                self.getReviewProducts()
                self.navTitle = "In Review"
            }
        }
    }
    
    func getReviewProducts() {
        CartService().getProductsInReview { (result) in
            if let result = result {
                self.reviewProducts = result.map(ReviewViewModel.init)
            }
        }
    }
}


