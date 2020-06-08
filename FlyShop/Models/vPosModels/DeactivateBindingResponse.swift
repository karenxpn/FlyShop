//
//  DeactivateBindingResponse.swift
//  FlyShop
//
//  Created by Karen Mirakyan on 6/5/20.
//  Copyright © 2020 Karen Mirakyan. All rights reserved.
//

import Foundation
struct DeactivateBindingResponse: Codable {
    var ResponseCode: String
    var ResponseMessage: String
    var CardHolderID: String
}
