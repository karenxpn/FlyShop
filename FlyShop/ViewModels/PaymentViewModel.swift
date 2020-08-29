//
//  PaymentViewModel.swift
//  FlyShop
//
//  Created by Karen Mirakyan on 6/16/20.
//  Copyright © 2020 Karen Mirakyan. All rights reserved.
//

import Foundation

class PaymentViewModel: ObservableObject {
    @Published var clientID: String = Credentials().clientID
    @Published var username: String = Credentials().username
    @Published var password: String = Credentials().password
    @Published var description: String = ""
    @Published var orderID: Int = 0
    @Published var amount: Decimal = 0
    @Published var showWeb: Bool = false
    @Published var showAddress: Bool = false
    @Published var paymentID: String = ""
    @Published var loading: Bool = false
    @Published var done: Bool = false
    @Published var showAlert: Bool = false
    @Published var activeAlert: ActiveAlert = .error
    @Published var errorMessage: String = "Ավելացրեք ապրանքներ Ձեր զամբյուղում"
    @Published var paymentDetails: PaymentDetailsResponse? = nil
    
    func initPayment() {
        
        InitPayment().updateOrderID { (updateResponse) in
            if let orderID = updateResponse {
                self.orderID = orderID
                
                let model = InitPaymentRequest(ClientID: self.clientID, Username: self.username, Password: self.password, Currency: nil, Description: self.description, OrderID: self.orderID, Amount: self.amount, BackURL: nil, Opaque: nil, CardHolderID: nil)
                InitPayment().initPayment( model: model) { (initPaymentResponse) in
                    if let response = initPaymentResponse {
                        if response.ResponseCode == 1 {
                            self.paymentID = response.PaymentID
                            self.showAddress = true
                        } else {

                            self.activeAlert = .error
                            self.showAlert = true
                            self.errorMessage = response.ResponseMessage
                        }
                    }
                }
            }
        }
        
    }
    
    func getResponse() {
        let model = PaymentDetailsRequest(PaymentID: self.paymentID, Username: self.username, Password: self.password)
        GetPaymentDetails().getDetails(model: model) { (response) in
            if let response = response {
                self.paymentDetails = response
                
                if self.done {
                    if response.ResponseCode == "00" {
                        
                        self.activeAlert = .success
                        self.showAlert = true
                        
                    }
                    else {
                        self.errorMessage = response.Description
                        self.activeAlert = .error
                        self.showAlert = true
                    }
                }
            }
        }
    }
}
