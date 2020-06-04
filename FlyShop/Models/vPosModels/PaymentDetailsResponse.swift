//
//  PaymentDetailsResponse.swift
//  FlyShop
//
//  Created by Karen Mirakyan on 6/4/20.
//  Copyright © 2020 Karen Mirakyan. All rights reserved.
//

import Foundation
struct PaymentDetailsResponse: Decodable {
    var Amount: Decimal
    var ApprovedAmount: Decimal
    var ApprovalCode: String
    var CardNumber: String
    var ClientName: String
    var ClientEmail: String
    var Currency: String
    var DateTime: String
    var DepositedAmount: Decimal
    var Description: String
    var MerchantId: String
    var Opaque: String
    var OrderID: Int
    var PaymentState: String
    //var PaymentType: PaymentsEnum TODO
    var ResponseCode: String
    var rrn: String
    var TerminalId: String
    var TrxnDescription: String
    var OrderStatus: Int
    var RefundedAmount: Decimal
    var CardHolderID: String
    var MDOrderID: String
    var PrimaryRC: String
    var ExpDate: String
    var ProcessingIP: String
    var BindingID: String
    var ActionCode: String
    var ExchangeRate: Decimal
}
