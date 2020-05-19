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

struct ReviewViewModel: Identifiable {
    let id = UUID()
    
    var reviewModel: ReviewModel
    
    init(model: ReviewModel) {
        self.reviewModel = model
    }
    
    var category: String {
        self.reviewModel.category
    }
    
    var image: [String] {
        self.reviewModel.image
    }
    
    var productPrice: Int {
        self.reviewModel.productPrice
    }
    
    var productName: String {
        self.reviewModel.productName
    }
    
    var productSize: [String] {
        self.reviewModel.productSize
    }
    
    var description: String {
        self.reviewModel.description
    }
    
    var date: String {
        self.reviewModel.date
    }
    
    var sale: Int {
        self.reviewModel.sale
    }
    
    var gender: String {
        self.reviewModel.gender
    }
    
    var type: String {
        self.reviewModel.type
    }
    
    var productId: String {
        self.reviewModel.productId
    }
    
    var size: String {
        self.reviewModel.size
    }
    
    var inReview: Bool {
        self.reviewModel.inReview
    }
    
    var available: Bool {
        self.reviewModel.available
    }

}
