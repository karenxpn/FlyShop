//
//  ProblemTransactions.swift
//  FlyShop
//
//  Created by Karen Mirakyan on 6/4/20.
//  Copyright © 2020 Karen Mirakyan. All rights reserved.
//

import Foundation
struct ProblemTransactions: Decodable {
    var CardNumber: String
    var ErrorMessage: String
    var OrderID: Int
    var PaymentDate: String
    var PaymentSum: Decimal
}
