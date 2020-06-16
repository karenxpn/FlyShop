//
//  InitPayment.swift
//  FlyShop
//
//  Created by Karen Mirakyan on 6/15/20.
//  Copyright © 2020 Karen Mirakyan. All rights reserved.
//

import Foundation
class InitPayment {
    func initPayment( model: InitPaymentRequest ,completion: @escaping ( InitPaymentResponse? ) -> () ) {
        guard let postURL = URL(string: "https://servicestest.ameriabank.am/VPOS/api/VPOS/InitPayment" ) else {
            DispatchQueue.main.async {
                completion( nil )
            }
            return
        }
        
        var request = URLRequest(url: postURL)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(model)

        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data, error == nil else {
                DispatchQueue.main.async {
                    completion( nil )
                }
                return
            }
            
            let response = try? JSONDecoder().decode(InitPaymentResponse.self, from: data)
            DispatchQueue.main.async {
                completion( response )
            }
        }.resume()
    }
}
