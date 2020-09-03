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
    @Published var shippingProductsList = ShippingModel(products: [ShippingProductModel]())
    @Published var navTitle: String = "Իմ զամբյուղը"
    @Published var orderDetails: OrderDetails? = nil
    @Published var client: String = ""
    @Published var address: String = ""
    
    init(){
        shippingProducts()
    }
    
    func postProducts() {
        CartService().postOrderToFirestore(address: self.address, cardHolder: self.client, paymentDetails: self.orderDetails ?? OrderDetails(PaymentID: "", Amount: 0), cartModelArray: cartProducts) { (response) in
            if response == true {
                self.cartProducts.removeAll(keepingCapacity: false)
            } else {
                print("Something went wrong")
            }
        }
    }
    
    func shippingProducts() {
        CartService().getShippingProducts { (response) in
            if let response = response {
                self.shippingProductsList = response
            }
        }
    }
}


