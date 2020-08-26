//
//  ARViewModel.swift
//  FlyShop
//
//  Created by Karen Mirakyan on 7/19/20.
//  Copyright © 2020 Karen Mirakyan. All rights reserved.
//

import Foundation
class ARViewModel: ObservableObject {
    @Published var selectedModel: Model?
    @Published var productName: String = ""
    
    func getAR() {
        ARService().fetchARProduct(productName: self.productName) { (searchResponse) in
            if searchResponse == nil {
                print("something went wrong")
            } else {
                ARService().getARProductWithPath(path: searchResponse!) { (model) in
                    self.selectedModel = model
                }
            }
        }
    }
}
