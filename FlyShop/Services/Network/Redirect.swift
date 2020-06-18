//
//  Redirect.swift
//  FlyShop
//
//  Created by Karen Mirakyan on 6/18/20.
//  Copyright © 2020 Karen Mirakyan. All rights reserved.
//

import Foundation
import Alamofire
class Redirect {
    func redirection( paymentID: String ) {
        AF.request("https://servicestest.ameriabank.am/VPOS/Payments/Pay?id=\(paymentID)").responseData { (response) in
            if let data = response.data {
                print(data)
            }
        }
    }
}
