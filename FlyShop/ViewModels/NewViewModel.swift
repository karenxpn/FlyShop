//
//  NewViewModel.swift
//  FlyShop
//
//  Created by Karen Mirakyan on 5/7/20.
//  Copyright © 2020 Karen Mirakyan. All rights reserved.
//

import Foundation
class NewViewModel: ObservableObject {
    @Published var newItemList = [ProductViewModel]()
    @Published var showLoading: Bool = false
    
    init() {
        getNewItems()
    }
    
    func getNewItems() {
        self.showLoading = true
        NewService().getNew { (result) in
            if let result = result {
                self.newItemList = result.map( ProductViewModel.init )
                self.showLoading = false
            }
        }
    }
}


