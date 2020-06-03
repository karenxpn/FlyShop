//
//  FilterViewModel.swift
//  FlyShop
//
//  Created by Karen Mirakyan on 5/6/20.
//  Copyright © 2020 Karen Mirakyan. All rights reserved.
//

import Foundation

class FilterViewModel: ObservableObject {
    @Published var checkedSale: Bool = false
    @Published var checkedNew: Bool = false
    @Published var maleGender: Bool = false
    @Published var femaleGender: Bool = false
    @Published var category: String = "Հագուստ"
    @Published var size = [String]()
    @Published var brand: String = ""
    @Published var price: Double = 400000
    @Published var type: String = ""
    
    
    @Published var filteredItems = [ProductViewModel]()
    
    func getFilteredData() {
        FilterService().fetchFilteredData(new: self.checkedNew, sale: self.checkedSale, brand: brand, category: category, gender: self.maleGender ? "Արական" : "Իգական", size: self.size, type: self.type, price: self.price) { (result) in
            if let result = result {
                self.filteredItems = result.map(ProductViewModel.init)
            }
        }
    }
}
