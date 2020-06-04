//
//  TransactionClientResponse.swift
//  FlyShop
//
//  Created by Karen Mirakyan on 6/4/20.
//  Copyright © 2020 Karen Mirakyan. All rights reserved.
//

import Foundation
struct TransactionClientResponse: Decodable {
    var Amount: Decimal
    var ApprovedAmount: Decimal
    var AuthCode: String
    var CardNumber: String
    var ClientName: String
    var Currency: String
    var DepositAmount: Decimal
    var Descr: String
    var ErrorMessage: String
    var Opaque: String
    var OperDate: String
    var OrderID: String
    var PaymentID: String
    var PaymentState: String
    var PaymentType: Int
    var RRN: String
    var RespCode: String
    var Stan: String
    var TrxnDetails: String
}
