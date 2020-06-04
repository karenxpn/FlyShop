//
//  CancelPaymentRequest.swift
//  FlyShop
//
//  Created by Karen Mirakyan on 6/4/20.
//  Copyright © 2020 Karen Mirakyan. All rights reserved.
//

import Foundation
struct CancelPaymentRequest: Codable {
    var PaymentID: String
    var Username: String
    var Password: String
}
