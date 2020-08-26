//
//  InitPayment.swift
//  FlyShop
//
//  Created by Karen Mirakyan on 6/15/20.
//  Copyright © 2020 Karen Mirakyan. All rights reserved.
//

import Foundation
import Alamofire
import Firebase

class InitPayment {
    
    func fetchOrderID(completion: @escaping( Int? ) -> ()) {
        let db = Firestore.firestore()
        
        db.collection("OrderID").document("ORDERID").addSnapshotListener { (snapshot, error) in
            if error != nil {
                DispatchQueue.main.async {
                    completion( nil )
                }
                return
            }
            
            if snapshot?.exists == true {
                if let orderID = snapshot!.get("OrderID") as? Int{
                    DispatchQueue.main.async {
                        completion( orderID )
                    }
                }
            }
        }
    }
    
    func updateOrderID( completion: @escaping( Bool ) -> () ) {
        let db = Firestore.firestore()
        
        db.collection("OrderID").document("ORDERID").updateData(["OrderID" : FieldValue.increment(1.0)]) { (error) in
            if error != nil {
                DispatchQueue.main.async {
                    completion( false )
                }
                return
            }
            
            DispatchQueue.main.async {
                completion( true )
            }
        }
    }
    
    
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
