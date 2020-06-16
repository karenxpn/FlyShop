//
//  PaymentViewModel.swift
//  FlyShop
//
//  Created by Karen Mirakyan on 6/16/20.
//  Copyright © 2020 Karen Mirakyan. All rights reserved.
//

import Foundation

class PaymentViewModel: ObservableObject {
    @Published var clientID: String = "1bc755b5-b1e3-4b2f-a005-eec8f7f4d300"
    @Published var username: String = "3d19541048"
    @Published var password: String = "lazY2k"
    @Published var description: String = ""
    @Published var orderID: Int = 2335103
    @Published var amount: Decimal = 10.0
    @Published var showWeb: Bool = false
    @Published var paymentID: String = ""
    
    func initPayment() {
        let model = InitPaymentRequest(ClientID: self.clientID, Username: self.username, Password: self.password, Currency: nil, Description: self.description, OrderID: self.orderID, Amount: self.amount, BackURL: nil, Opaque: nil, CardHolderID: nil)
        InitPayment().initPayment( model: model) { (initPaymentResponse) in
            if let response = initPaymentResponse {
                if response.ResponseCode == 1 {
                    self.paymentID = response.PaymentID
                    print("https://servicestest.ameriabank.am/VPOS/Payments/Pay?id=\(self.paymentID)&lang=am")
                    self.showWeb = true
                }
                print(response)
            }
        }
    }
}
