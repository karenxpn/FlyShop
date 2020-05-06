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
    @Published var clothes: Bool = false
    @Published var shoes: Bool = false
    @Published var accessories: Bool = false
    @Published var price: Double = 0
}
