//
//  GetBindingsResponse.swift
//  FlyShop
//
//  Created by Karen Mirakyan on 6/4/20.
//  Copyright © 2020 Karen Mirakyan. All rights reserved.
//

import Foundation
struct GetBindingsResponse: Decodable {
    var ResponseCode: String
    var ResponseMessage: String
    var CardBindingFileds: [CardBindingFiled]
}
