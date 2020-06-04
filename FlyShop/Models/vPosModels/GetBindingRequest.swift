//
//  GetBindingRequest.swift
//  FlyShop
//
//  Created by Karen Mirakyan on 6/4/20.
//  Copyright © 2020 Karen Mirakyan. All rights reserved.
//

import Foundation
struct GetBindingRequest: Codable {
    var ClientID: String
    var Password: String
    var Username: String
    //var PaymentType: enum
}
