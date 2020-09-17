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
    
    
    func updateOrderID( completion: @escaping( Int? ) -> () ) {
        let db = Firestore.firestore()
        let sfReference = db.collection("OrderID").document("ORDERID")
        
        db.runTransaction{ (transaction, errorPointer) -> Any? in
            let sfDocument: DocumentSnapshot
            do {
                try sfDocument = transaction.getDocument(sfReference)
            } catch let fetchError as NSError {
                errorPointer?.pointee = fetchError
                return nil
            }
            
            guard let orlOrderID = sfDocument.get("OrderID") as? Int else {
                let error = NSError(
                    domain: "AppErrorDomain",
                    code: -1,
                    userInfo: [
                        NSLocalizedDescriptionKey: "Unable to retrieve population from snapshot \(sfDocument)"
                    ]
                )
                errorPointer?.pointee = error
                return nil
            }
            
            transaction.updateData(["OrderID": orlOrderID + 1], forDocument: sfReference)
            return orlOrderID + 1
        } completion: { (object, error) in
            if error != nil {
                DispatchQueue.main.async {
                    completion( nil )
                }
            } else {
                if let orderID = object as? Int {
                    DispatchQueue.main.async {
                        completion( orderID )
                    }
                }
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
