//
//  CartViewModel.swift
//  FlyShop
//
//  Created by Karen Mirakyan on 5/13/20.
//  Copyright © 2020 Karen Mirakyan. All rights reserved.
//

import Foundation

class CartViewModel: ObservableObject {
    @Published var cartProducts = [CartModel]()
}
