//
//  PaymentDetailsResponse.swift
//  FlyShop
//
//  Created by Karen Mirakyan on 6/4/20.
//  Copyright © 2020 Karen Mirakyan. All rights reserved.
//

import Foundation

//enum PaymentsEnum: Int {
//    case None = 0
//    case Arca = 1
//    case MasterCard = 2
//    case Visa = 3
//    case Reward = 4
//    case MainRest = 5
//    case BindingMainRest = 6
//    case PayPal = 7
//    case PayX = 11
//}

struct PaymentDetailsResponse: Codable {
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
    var OrderID: String
    var PaymentState: String
    var PaymentType: Int
    var ResponseCode: String
    var rrn: String
    var TerminalId: String
    var TrxnDescription: String
    var OrderStatus: String
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
