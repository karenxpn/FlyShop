//
//  InitPayment.swift
//  FlyShop
//
//  Created by Karen Mirakyan on 6/15/20.
//  Copyright © 2020 Karen Mirakyan. All rights reserved.
//

import Foundation
import Alamofire

class InitPayment {
    func initPayment( model: InitPaymentRequest ,completion: @escaping ( InitPaymentResponse? ) -> () ) {
        guard let postURL = URL(string: "\(URLS().BASE_URL)InitPayment" ) else {
            DispatchQueue.main.async {
                completion( nil )
            }
            return
        }
        
        AF.request(postURL,
                   method: .post,
                   parameters: model,
                   encoder: JSONParameterEncoder.default).responseDecodable(of: InitPaymentResponse.self) { (response) in
                    DispatchQueue.main.async {
                        completion( response.value)
                    }
        }
    }
}
