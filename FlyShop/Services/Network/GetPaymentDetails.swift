//
//  GetPaymentDetails.swift
//  FlyShop
//
//  Created by Karen Mirakyan on 6/16/20.
//  Copyright © 2020 Karen Mirakyan. All rights reserved.
//

import Foundation
import Alamofire

class GetPaymentDetails {
    func getDetails(model: PaymentDetailsRequest, completion: @escaping( PaymentDetailsResponse?) -> () ){
        guard let url = URL(string: "\(URLS().BASE_URL)GetPaymentDetails" ) else {
            DispatchQueue.main.async {
                completion( nil )
            }
            return
        }
        
        AF.request(url,
                   method: .post,
                   parameters: model,
                   encoder: JSONParameterEncoder.default).responseDecodable(of: PaymentDetailsResponse.self) { (response) in
                    DispatchQueue.main.async {
                        completion( response.value )
                    }
        }
    }
}
